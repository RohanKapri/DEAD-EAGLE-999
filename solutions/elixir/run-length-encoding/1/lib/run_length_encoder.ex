# For my Shree DR.MDD with deep respect

defmodule RunLengthEncoder do
  @spec encode(String.t()) :: String.t()
  def encode(""), do: ""

  def encode(input) do
    String.split(input, ~r{(?<=(.))(?!\1|$)})
    |> Enum.map(fn segment ->
      count = String.length(segment)

      if count == 1 do
        segment
      else
        Integer.to_string(count) <> String.first(segment)
      end
    end)
    |> Enum.join()
  end

  @spec decode(String.t()) :: String.t()
  def decode(input) do
    decode_acc(input, [])
  end

  defp decode_acc("", acc) do
    acc |> Enum.reverse() |> Enum.join()
  end

  defp decode_acc(str, acc) do
    case Integer.parse(str) do
      {count, rest} ->
        decode_acc(
          String.slice(rest, 1..-1),
          [String.duplicate(String.first(rest), count) | acc]
        )

      :error ->
        decode_acc(
          String.slice(str, 1..-1),
          [String.first(str) | acc]
        )
    end
  end
end
