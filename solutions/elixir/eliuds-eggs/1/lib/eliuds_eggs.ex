defmodule EliudsEggs do
  @doc """
  Given the number, count the number of eggs.
  """
  @spec egg_count(number :: integer()) :: non_neg_integer()
  def egg_count(number) do
  binaryString=Integer.to_string(number, 2)
  binaryString|> String.graphemes |> Enum.count(& &1 =="1")
  end
end