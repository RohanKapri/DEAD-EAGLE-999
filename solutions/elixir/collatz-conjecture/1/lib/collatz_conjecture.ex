defmodule CollatzConjecture do
  @doc """
  calc/1 takes an integer and returns the number of steps required to get the
  number to 1 when following the rules:
    - if number is odd, multiply with 3 and add 1
    - if number is even, divide by 2
  """
  @spec calc(input :: pos_integer()) :: non_neg_integer()
  def calc(input), do: _calc(input, 0)

  defp _calc(1, res), do: res
  defp _calc(n, _) when n < 1 or not is_number(n), do: raise(FunctionClauseError)
  defp _calc(n, res) when rem(n, 2) == 0, do: _calc(trunc(n / 2), res + 1)
  defp _calc(n, res), do: _calc(3 * n + 1, res + 1)
end