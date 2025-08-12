defmodule JigsawPuzzle do
  @doc """
  Fill in missing jigsaw puzzle details from partial data
  """

  @type format() :: :landscape | :portrait | :square
  @type t() :: %__MODULE__{
          pieces: pos_integer() | nil,
          rows: pos_integer() | nil,
          columns: pos_integer() | nil,
          format: format() | nil,
          aspect_ratio: float() | nil,
          border: pos_integer() | nil,
          inside: pos_integer() | nil
        }

  defstruct [:pieces, :rows, :columns, :format, :aspect_ratio, :border, :inside]

  @spec data(jigsaw_puzzle :: JigsawPuzzle.t()) ::
          {:ok, JigsawPuzzle.t()} | {:error, String.t()}
  def data(puzzle = %__MODULE__{}),
    do: MapConsistency.make_consistent(puzzle,
          [
            {:pieces, [:rows, :columns], fn rows, columns -> rows * columns end},
            {:rows, [:pieces, :columns], fn pieces, columns -> div(pieces, columns) end},
            {:rows, [:aspect_ratio, :columns], fn aspect_ratio, columns -> floor(columns / aspect_ratio) end},
            {:rows, [:pieces, :aspect_ratio], fn pieces, aspect_ratio ->
                                                Enum.find(1..pieces, &floor(&1 * &1 * aspect_ratio) == pieces)
                                              end},
            {:rows, [:pieces, :border, :format], fn
              pieces, border, :portrait -> Enum.find_value(1..floor(border / 4) - 1, fn columns ->
                                              rows = floor(border / 2) - columns + 2
                                              if(rows * columns == pieces, do: rows)
                                            end)
              pieces, border, :landscape -> Enum.find_value(1..floor(border / 4) - 1, fn rows ->
                                              columns = floor(border / 2) - rows + 2
                                              if(rows * columns == pieces, do: rows)
                                            end)
              pieces, border, :square -> Enum.find_value(1..floor(border / 4) + 1, fn rows ->
                                              columns = floor(border / 2) - rows + 2
                                              if(rows * columns == pieces, do: rows)
                                            end)
            end},
            {:rows, [:columns, {:format, :square}], fn columns -> columns end},
            {:rows, [:inside, {:aspect_ratio, 1.0}], fn inside -> Enum.find(1..inside, & &1 * &1 == inside) + 2 end},
            {:columns, [:rows, {:format, :square}], fn rows -> rows end},
            {:columns, [:pieces, :rows], fn pieces, rows -> div(pieces, rows) end},
            {:columns, [:aspect_ratio, :rows], fn aspect_ratio, rows -> floor(aspect_ratio * rows) end},
            {:format, [:aspect_ratio], fn
              1.0 -> :square
              landscape when landscape > 1.0 -> :landscape
              portrait when portrait < 1.0 -> :portrait
            end},
            {:aspect_ratio, [:rows, :columns], fn rows, columns -> columns / rows end},
            {:border, [:rows, :columns], fn rows, columns -> 2 * (rows + columns - 2) end},
            {:inside, [:pieces, :border], fn pieces, border -> pieces - border end},
          ])
end

defmodule MapConsistency do
  @doc """
  Establishes consistency of a map by applying a set of rules.

  This is a two phase state-machine:
  - In the first phase, completion, the map is completed stepwise by applicable rules (i.e. the first rule, where the defined
  aspect is missing and all defining aspects are available). This is continued until no more rules are applicable
  - In the second phase, verification, the same rules are used to check if every aspect is set and consistent with the apsects defining it
  """
  def make_consistent(map, rules) when is_map(map) and is_list(rules), do: apply_rules({:completion, map}, rules)

  defp apply_rules({:completion, map}, rules) do
    case Enum.find(rules, &rule_applicable?(&1, map)) do
      applicable_rule = {defined_aspect, _defining_aspects, _fun} ->
        apply_rules({:completion, Map.put(map, defined_aspect, defined_value(map, applicable_rule))}, rules)
      nil -> apply_rules({:verification, map}, rules)
    end
  end

  defp apply_rules({:verification, map}, rules),
    do:
      Enum.find_value(rules, fn {defined_aspect, _defining_aspects, _fun} = rule ->
        aspect_value = Map.get(map, defined_aspect)
        if(aspect_value == nil,
          do: {:error, "Insufficient data"},
          else: if(aspect_retrievable?(rule, map) and aspect_value != defined_value(map, rule), do: {:error, "Contradictory data"}))
      end) || {:ok, map}

  defp aspect_retrievable?({_defined_aspect, defining_aspects, _fun}, map),
      do: Enum.all?(defining_aspects, fn
      {aspect, value} when is_atom(aspect) -> Map.get(map, aspect) == value
      aspect when is_atom(aspect) -> Map.get(map, aspect) != nil
    end)

  defp rule_applicable?({defined_aspect, _defining_aspects, _fun} = rule, map),
    do: Map.get(map, defined_aspect) == nil and aspect_retrievable?(rule, map)

  defp defined_value(map, {_defined_aspect, [aspect_1], fun}) when is_function(fun, 1),
    do: fun.(Map.get(map, aspect_1))

  defp defined_value(map, {_defined_aspect, [aspect_1, {_aspect, _expected_value}], fun}) when is_function(fun, 1),
    do: fun.(Map.get(map, aspect_1))

  defp defined_value(map, {_defined_aspect, [aspect_1, aspect_2], fun}) when is_function(fun, 2),
    do: fun.(Map.get(map, aspect_1), Map.get(map, aspect_2))

  defp defined_value(map, {_defined_aspect, [aspect_1, aspect_2, aspect_3], fun}) when is_function(fun, 3),
    do: fun.(Map.get(map, aspect_1), Map.get(map, aspect_2), Map.get(map, aspect_3))

end