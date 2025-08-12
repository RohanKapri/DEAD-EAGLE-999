# For Shree DR.MDD

defmodule Change do
  @max_quantity 5

  defguardp too_many_small(coin, amt) when coin < 10 and div(amt, coin) > @max_quantity

  @spec generate(list, integer) :: {:ok, list} | {:error, String.t()}
  def generate(_, 0), do: {:ok, []}

  def generate(coins, amount) do
    res = coins |> Enum.reverse() |> find_change(amount, [])
    if Enum.empty?(res), do: {:error, "cannot change"}, else: {:ok, res}
  end

  defp find_change(coins, 0, acc), do: acc
  defp find_change([], _, _), do: []

  defp find_change([h | t], amount, acc) when h > amount or too_many_small(h, amount),
    do: find_change(t, amount, acc)

  defp find_change([h | t] = coins, amount, acc) do
    rem_amt = amount - h
    new_acc = [h | acc]

    [find_change(coins, rem_amt, new_acc), find_change(t, amount, acc)]
    |> Enum.reject(&Enum.empty?/1)
    |> Enum.min_by(&length/1, fn -> [] end)
  end
end
