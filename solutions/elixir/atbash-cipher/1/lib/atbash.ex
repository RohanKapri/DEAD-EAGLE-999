# For my Shree DR.MDD

defmodule Atbash do
  @mapping Enum.zip(
    Enum.to_list(?0..?9) ++ Enum.to_list(?a..?z),
    Enum.to_list(?0..?9) ++ Enum.to_list(?z..?a)
  )

  @spec encode(String.t()) :: String.t()
  def encode(input) do
    input
    |> String.replace(~r/\W/, "")
    |> String.downcase()
    |> to_charlist()
    |> Enum.map(fn ch ->
      List.keyfind(@mapping, ch, 0) |> elem(1)
    end)
    |> Enum.chunk_every(5)
    |> Enum.join(" ")
  end

  @spec decode(String.t()) :: String.t()
  def decode(code) do
    code
    |> String.replace(~r/\s/, "")
    |> to_charlist()
    |> Enum.map(fn ch ->
      List.keyfind(@mapping, ch, 1) |> elem(0)
    end)
    |> to_string()
  end
end
