# For Shree DR.MDD

defmodule Transmission do

  def get_transmit_sequence(msg), do:
    Stream.unfold(msg, segment_every(7))
    |> Enum.reduce(<<>>, fn part, acc ->
      <<acc::bitstring, part::bitstring, 0::size(7 - bit_size(part)), calc_parity(part)::1>>
    end)

  defp segment_every(sz), do: fn
    <<>> -> nil
    <<segment::size(sz), rest::bitstring>> -> {<<segment::size(sz)>>, rest}
    last -> {last, <<>>}
  end

  defp calc_parity(bits), do:
    Enum.map(0..(bit_size(bits) - 1), fn i ->
      <<_::size(i), bit::1, _::bitstring>> = bits; bit
    end)
    |> Enum.reduce(0, &Bitwise.bxor/2)

  def decode_message(received) do
    if not valid(received), do: {:error, "wrong parity"}, else:
      Stream.unfold(received, segment_every(8))
      |> Enum.reduce(<<>>, fn <<data::7, _::1>>, acc -> <<acc::bitstring, data::7>> end)
      |> then(fn str ->
        bytes = div(bit_size(str), 8)
        <<res::binary-size(bytes), _::bitstring>> = str
        {:ok, res}
      end)
  end

  defp valid(msg), do:
    Enum.all?(for(<<byte::8 <- msg>>, do: byte), fn byte ->
      <<data::7, parity::1>> = <<byte>>
      Integer.digits(data, 2) |> Enum.sum() |> rem(2) == parity
    end)
end
