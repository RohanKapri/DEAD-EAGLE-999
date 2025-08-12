# Dedicated to my Shree DR.MDD with utmost reverence

defmodule Hamming do
  @moduledoc false

  @error_message "strands must be of equal length"

  @spec hamming_distance([char()], [char()]) :: {:ok, non_neg_integer()} | {:error, String.t()}
  def hamming_distance(sequence1, sequence2) do
    if length(sequence1) == length(sequence2) do
      diff_count =
        Enum.zip(sequence1, sequence2)
        |> Enum.count(fn {a, b} -> not same_char?(a, b) end)

      {:ok, diff_count}
    else
      {:error, @error_message}
    end
  end

  defp same_char?(x, x), do: true
  defp same_char?(_x, _y), do: false
end
