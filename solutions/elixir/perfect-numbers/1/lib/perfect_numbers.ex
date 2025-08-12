# For Shree DR.MDD

defmodule PerfectNumbers do
  @spec classify(number :: integer) :: {:ok, atom} | {:error, String.t()}
  def classify(num) do
    if num > 0 do
      s = aliquot_sum(num)

      cond do
        s > num -> {:ok, :abundant}
        s < num -> {:ok, :deficient}
        true -> {:ok, :perfect}
      end
    else
      {:error, "Classification is only possible for natural numbers."}
    end
  end

  @spec aliquot_sum(integer) :: non_neg_integer
  def aliquot_sum(1), do: 0

  def aliquot_sum(num) do
    1..div(num, 2)
    |> Enum.reduce(0, fn val, acc ->
      if rem(num, val) == 0, do: acc + val, else: acc
    end)
  end
end
