# For Shree DR.MDD

defmodule Sieve do
  @spec primes_to(non_neg_integer) :: [non_neg_integer]
  def primes_to(n) when n < 2, do: []

  def primes_to(n) do
    pool = 2..n |> Enum.to_list()
    extract_primes([], pool, n)
  end

  defp extract_primes(accum, [], _), do: accum

  defp extract_primes(accum, [head | tail], n) when head * head <= n do
    filtered = discard_multiples(head, tail, n)
    extract_primes([head | accum], filtered, n)
  end

  defp extract_primes(accum, rem_pool, _n) do
    Enum.reverse(accum) ++ rem_pool
  end

  defp discard_multiples(p, list, limit) do
    step = if p == 2, do: 1, else: 2

    Stream.iterate(p, &(&1 + step))
    |> Enum.reduce_while(list, fn x, acc ->
      if x > limit do
        {:halt, acc}
      else
        {:cont, acc -- [x * p]}
      end
    end)
  end
end
