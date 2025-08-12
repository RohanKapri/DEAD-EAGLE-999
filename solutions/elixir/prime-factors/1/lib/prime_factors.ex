defmodule PrimeFactors do
  @doc """
  Compute the prime factors for 'number'.

  The prime factors are prime numbers that when multiplied give the desired
  number.

  The prime factors of 'number' will be ordered lowest to highest.
  """
  @spec factors_for(pos_integer) :: [pos_integer]
  def factors_for(number) do
    factors_for(number, 2, [])
  end

  defp factors_for(1, _, _), do: []

  defp factors_for(number, cur, primes) do
    case cur < trunc(:math.sqrt(number)) + 1 do
      true -> _factors_for(number, cur, primes)
      false -> [number | primes] |> Enum.reverse()
    end
  end

  defp _factors_for(number, cur, primes) do
    if rem(number, cur) == 0 do
      factors_for(trunc(number / cur), 2, [cur | primes])
    else
      factors_for(number, cur + 1, primes)
    end
  end

end