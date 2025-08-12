defmodule Prime do
  @doc """
  Generates the nth prime.
  """
  @spec nth(non_neg_integer) :: non_neg_integer
  def nth(count) when count <= 0, do: raise(ArgumentError)
  def nth(count), do: generate() |> Enum.at(count - 1)

  @doc """
  Generates the lazy sequence of primes.
  """
  @spec generate() :: Enum.t()
  def generate do
    # infinity range (1..)
    Stream.iterate(1, &(&1 + 1))
    |> Stream.filter(&is_prime?/1)
  end

  @doc """
  Checks if a number is prime.
  """
  @spec is_prime?(non_neg_integer) :: boolean
  def is_prime?(n) when n < 2, do: false
  def is_prime?(2), do: true

  def is_prime?(n) do
    2..(trunc(:math.sqrt(n)) + 1)
    |> Enum.all?(fn x -> rem(n, x) != 0 end)
  end
end