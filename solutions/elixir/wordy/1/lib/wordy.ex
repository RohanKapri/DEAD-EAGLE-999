defmodule Wordy do
  @phrases_and_functions %{
    "What is" => :initial,
    "plus" => &Kernel.+/2,
    "minus" => &Kernel.-/2,
    "multiplied by" => &Kernel.*/2,
    "divided by" => &Kernel.div/2,
    "?" => :final
  }

  @doc """
  Calculate the math problem in the sentence.
  """
  @spec answer(String.t()) :: integer
  def answer(expression),
    do:
      expression
      |> evaluate()
      |> then(fn
        result when is_integer(result) -> result
        _ -> raise ArgumentError
      end)

  # evaluates a given wellformed binary expression recursively
  defp evaluate(expression, value \\ nil)
  # generates one clause for each defined phrase of the vocabulary
  Enum.each(@phrases_and_functions, fn
    {phrase, :initial} ->
      defp evaluate(unquote(phrase) <> " " <> expression, nil),
        do:
          with(
            {first_value, expression} <- Integer.parse(expression),
            do: evaluate(expression, first_value)
          )
    {phrase, fun} when is_function(fun, 2)->
      defp evaluate(" " <> unquote(phrase) <> " " <> expression, value),
        do:
          with(
            {number, expression} <- Integer.parse(expression),
            next_value <- unquote(fun).(value, number),
            do: evaluate(expression, next_value)
          )
    {phrase, :final} ->
      defp evaluate(unquote(phrase), value), do: value
  end)
  # and the good, old catch all
  defp evaluate(_, _), do: :unknown
end