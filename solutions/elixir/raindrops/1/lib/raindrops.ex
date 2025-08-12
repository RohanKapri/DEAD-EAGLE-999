defmodule Raindrops do
  @moduledoc false

  @raindrop %{3 => "Pling", 5 => "Plang", 7 => "Plong"}

  @doc """
  Returns a string based on raindrop factors.

  - If the number contains 3 as a prime factor, output 'Pling'.
  - If the number contains 5 as a prime factor, output 'Plang'.
  - If the number contains 7 as a prime factor, output 'Plong'.
  - If the number does not contain 3, 5, or 7 as a prime factor,
    just pass the number's digits straight through.
  """
  @spec convert(pos_integer) :: String.t()
  def convert(number) when is_number(number) and number > 0 do
    number
    |> all_factors()
    |> List.foldl("", &(&2 <> to_string(@raindrop[&1])))
    |> empty_string?(to_string(number))
  end

  def convert(number), do: IO.puts("Wrong number: #{inspect(number)}")

  defp all_factors(1), do: [1]

  defp all_factors(number) do
    1..div(number, 2)
    |> Enum.filter(&(rem(number, &1) == 0))
    |> Kernel.++([number])
  end

  defp empty_string?("", value), do: value
  defp empty_string?(str, _), do: str
end