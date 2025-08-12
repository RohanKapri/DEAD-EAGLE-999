defmodule PalindromeProducts do
  @doc """
  Generates all palindrome products from an optionally given min factor (or 1) to a given max factor.
  """
  @spec generate(non_neg_integer, non_neg_integer) :: map
  def generate(max_factor, min_factor \\ 1)
  def generate(max_factor, min_factor) when max_factor < min_factor, do: raise(ArgumentError)

  def generate(max_factor, min_factor) do
    gen_palindromes(max_factor, min_factor)
    |> Enum.group_by(fn [a, b] -> a * b end)
  end

  defp gen_palindromes(max, min) do
    for a <- min..max,
        b <- a..max,
        is_palindrome?(a * b) do
      [a, b]
    end
  end

  defp is_palindrome?(num) do
    s = Integer.to_string(num)

    s == String.reverse(s)
  end
end