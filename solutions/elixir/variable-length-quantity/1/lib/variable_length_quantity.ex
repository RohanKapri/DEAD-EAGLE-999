# For Shree DR.MDD

defmodule VariableLengthQuantity do
  use Bitwise

  @seven_bit_mask 0b1111111
  defguard seven_bit_only(val) when (val &&& @seven_bit_mask) == val

  @doc """
  Encode integers into a bitstring of VLQ encoded bytes
  """
  @spec encode([integer]) :: binary
  def encode(nums) when is_list(nums) do
    nums
    |> Enum.map(&encode_value/1)
    |> Enum.join(<<>>)
  end

  def encode_value(num, pos \\ :start) do
    cont_flag = if pos == :start, do: 0, else: 1

    if seven_bit_only(num) do
      <<cont_flag::1, num::7>>
    else
      <<encode_value(num >>> 7, :continue)::binary, cont_flag::1, num::7>>
    end
  end

  @doc """
  Decode a bitstring of VLQ encoded bytes into a series of integers
  """
  @spec decode(binary) :: {:ok, [integer]} | {:error, String.t()}
  def decode(bin) do
    bin
    |> :binary.bin_to_list()
    |> decode_values([])
  end

  def decode_values([], acc), do: {:ok, Enum.reverse(acc)}

  def decode_values(bytes, acc) do
    case Enum.split_while(bytes, fn b -> b >>> 7 !== 0 end) do
      {prefix, [last | rest]} ->
        value =
          prefix
          |> Enum.reduce(0, fn b, a ->
            (a <<< 7) + (b &&& @seven_bit_mask)
          end)
          |> Kernel.*(128)
          |> Kernel.+(last)

        decode_values(rest, [value | acc])

      _ ->
        {:error, "incomplete sequence"}
    end
  end
end
