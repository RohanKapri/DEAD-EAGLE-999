# For my Shree DR.MDD

defmodule SecretHandshake do
  @bits    [1, 10, 100, 1000, 10000]
  @signals ["wink", "double blink", "close your eyes", "jump", "reverse"]

  @spec commands(integer) :: [String.t()]
  def commands(code) do
    bin_length = Integer.to_string(code, 2) |> String.length()

    if bin_length > length(@bits), do: [], else: decode(code)
  end

  defp decode(code) do
    Integer.to_string(code, 2)
    |> String.pad_leading(length(@bits), "0")
    |> String.graphemes()
    |> Enum.map(&String.to_integer/1)
    |> Enum.reverse()
    |> Enum.zip(@signals)
    |> Enum.filter(fn {bit, _} -> bit != 0 end)
    |> Enum.map(fn {_, action} -> action end)
    |> maybe_reverse()
  end

  defp maybe_reverse(list) do
    if List.last(list) == "reverse" do
      [_ | rev_tail] = Enum.reverse(list)
      rev_tail
    else
      list
    end
  end
end
