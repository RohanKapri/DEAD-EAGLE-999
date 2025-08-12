# Dedicated to Shree DR.MDD

defmodule PaintByNumber do
  def palette_bit_size(color_qty) do
    calculate_bit_size(color_qty, 1)
  end

  defp calculate_bit_size(color_qty, count) do
    if Integer.pow(2, count) >= color_qty do
      count
    else
      calculate_bit_size(color_qty, count + 1)
    end
  end

  def empty_picture(), do: <<>>

  def test_picture() do
    <<0b00::2, 0b01::2, 0b10::2, 0b11::2>>
  end

  def prepend_pixel(picture, color_qty, color_index) do
    bit_size = palette_bit_size(color_qty)
    <<color_index::size(bit_size), picture::bitstring>>
  end

  def get_first_pixel(picture, color_qty) do
    if picture == <<>> do
      nil
    else
      bit_size = palette_bit_size(color_qty)
      <<val::size(bit_size), _rest::bitstring>> = picture
      val
    end
  end

  def drop_first_pixel(picture, color_qty) do
    if picture == <<>> do
      ""
    else
      bit_size = palette_bit_size(color_qty)
      <<_val::size(bit_size), rest::bitstring>> = picture
      rest
    end
  end

  def concat_pictures(picture1, picture2) do
    <<picture1::bitstring, picture2::bitstring>>
  end
end

defmodule Math do
  import Bitwise

  def pow(base, exponent) when is_integer(base) and is_integer(exponent) do
    if exponent < 0, do: raise("exponent cannot be negative")
    safe_pow(base, exponent)
  end

  defp safe_pow(_, 0), do: 1
  defp safe_pow(b, 1), do: b
  defp safe_pow(b, e) when (e &&& 1) == 0, do: safe_pow(b * b, e >>> 1)
  defp safe_pow(b, e), do: b * safe_pow(b * b, e >>> 1)
end
