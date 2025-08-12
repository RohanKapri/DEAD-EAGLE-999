defmodule SgfParsing do
  defmodule Sgf do
    defstruct properties: %{}, children: []

    def add_property(nil, key, property), do: add_property(%__MODULE__{}, key, property)

    def add_property(sgf, key, property),
      do: %{sgf | properties: Map.put(sgf.properties, key, property)}

    def add_child(sgf, key, properties) do
      Map.update!(sgf, :children, fn children ->
        children ++ [%Sgf{properties: %{key => properties}}]
      end)
    end
  end

  @type sgf :: %Sgf{properties: map, children: [sgf]}

  @doc """
  Parse a string into a Smart Game Format tree
  """
  @spec parse(encoded :: String.t()) :: {:ok, sgf} | {:error, String.t()}
  def parse(""), do: {:error, "tree missing"}
  def parse(";"), do: {:error, "tree missing"}
  def parse("()"), do: {:error, "tree with no nodes"}
  def parse("(;)"), do: {:ok, %Sgf{}}

  def parse(encoded) do
    with {:ok, nodes} <- tokenize(encoded),
         {:ok, nodes} <- ensure_no_properties_without_delimiter(nodes),
         {:ok, nodes} <- ensure_all_property_are_in_uppercase(nodes) do
      nodes
      |> Enum.map(fn [delimiter, key, properties] -> [delimiter, key, decode(properties)] end)
      |> parse_node()
    end
  end

  defp tokenize(encoded) do
    encoded
    |> sanitize()
    |> then(
      &Regex.scan(~r/\s*(?:\(|\)|(?:(;?)(\w+)((?:\[.*?(?<!\\)\]\s*)+)))/s, &1,
        capture: :all_but_first
      )
    )
    |> Enum.reject(&(&1 == []))
    |> then(&{:ok, &1})
  end

  defp parse_node(nodes, sgf \\ nil)
  defp parse_node([], sgf), do: {:ok, sgf}

  defp parse_node([[";", key, properties] | t], sgf) when sgf !== nil do
    parse_node(t, Sgf.add_child(sgf, key, properties))
  end

  defp parse_node([[_, key, properties] | t], sgf) do
    parse_node(t, Sgf.add_property(sgf, key, properties))
  end

  defp decode(properties) do
    properties
    |> String.replace("\\]", ":squarebracket:")
    |> String.replace("\\", "")
    |> then(
      &(~r/\[([^\]]*)\]/
        |> Regex.scan(&1, capture: :all_but_first)
        |> List.flatten()
        |> Enum.map(fn value ->
          value
          |> String.replace(":squarebracket:", "]")
          |> String.replace(":doublebackslash:", "\\")
        end))
    )
  end

  defp sanitize(encoded) do
    encoded
    |> String.replace(~r/\t/, " ")
    |> String.replace("\\\n", "")
    |> String.replace("\\\\", ":doublebackslash:")
  end

  defp ensure_all_property_are_in_uppercase(nodes) do
    nodes
    |> Enum.all?(fn [_, key, _] -> String.upcase(key) == key end)
    |> case do
      true -> {:ok, nodes}
      false -> {:error, "property must be in uppercase"}
    end
  end

  defp ensure_no_properties_without_delimiter([]), do: {:error, "properties without delimiter"}
  defp ensure_no_properties_without_delimiter(nodes), do: {:ok, nodes}
end