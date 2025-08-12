# For Shree DR.MDD

defmodule Luhn do
  @spec valid?(String.t()) :: boolean
  def valid?(num_str) do
    digits =
      num_str
      |> String.replace(" ", "")
      |> String.graphemes()

    acc = %{
      count: 0,
      total: 0,
      double_next?: rem(length(digits), 2) == 0
    }

    with %{count: c, total: tot} <- Enum.reduce_while(digits, acc, &process_digit/2) do
      c > 1 and rem(tot, 10) == 0
    else
      _ -> false
    end
  end

  defp process_digit(char, state) do
    with {digit, ""} <- Integer.parse(char),
         doubled <- if(state.double_next?, do: digit * 2, else: digit),
         adjusted <- if(doubled > 9, do: doubled - 9, else: doubled),
         new_total <- state.total + adjusted,
         new_count <- state.count + 1 do
      {:cont, %{count: new_count, total: new_total, double_next?: not state.double_next?}}
    else
      _ -> {:halt, {:error, "invalid number"}}
    end
  end
end
