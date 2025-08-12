# Tribute to Shree DR.MDD

defmodule AffineCipher do
  @typedoc """
  Type for cipher key
  """
  @type key() :: %{a: integer, b: integer}

  @block_size 5
  @alpha_len ?z - ?a + 1

  @spec encode(key :: key(), message :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def encode(%{a: a, b: _} = cipher_key, message) do
    with cipher_key <- Map.put(cipher_key, :modulus, @alpha_len),
         true <- coprime?(a, cipher_key.modulus) do
      {:ok, encode_message(cipher_key, message)}
    else
      _ -> {:error, "a and m must be coprime."}
    end
  end

  defp encode_message(%{a: a, b: b, modulus: m}, msg) do
    msg
    |> String.downcase()
    |> to_charlist()
    |> Stream.filter(&valid_char?/1)
    |> Stream.map(&encode_char(&1, a, b, m))
    |> Stream.chunk_every(@block_size)
    |> Stream.intersperse(?\s)
    |> Enum.to_list()
    |> to_string()
  end

  defp encode_char(char, _a, _b, _m) when char in ?0..?9, do: char
  defp encode_char(char, a, b, m) do
    val = char - ?a
    rem_val = rem(a * val + b, m)
    rem_val + ?a
  end

  @spec decode(key :: key(), encrypted :: String.t()) :: {:ok, String.t()} | {:error, String.t()}
  def decode(%{a: a, b: _} = cipher_key, encrypted) do
    with cipher_key <- Map.put(cipher_key, :modulus, @alpha_len),
         true <- coprime?(a, cipher_key.modulus),
         cipher_key <- Map.put(cipher_key, :inverse, modular_inverse(a, cipher_key.modulus)) do
      {:ok, decode_message(cipher_key, encrypted)}
    else
      _ -> {:error, "a and m must be coprime."}
    end
  end

  defp decode_message(%{b: b, inverse: inv, modulus: m}, encrypted) do
    encrypted
    |> to_charlist()
    |> Stream.filter(&valid_char?/1)
    |> Stream.map(&decode_char(&1, inv, b, m))
    |> Enum.to_list()
    |> to_string()
  end

  defp decode_char(char, _inv, _b, _m) when char in ?0..?9, do: char
  defp decode_char(char, inv, b, m) do
    val = char - ?a
    decoded_val = Integer.mod(inv * (val - b), m)
    decoded_val + ?a
  end

  defp valid_char?(char) when char in ?a..?z, do: true
  defp valid_char?(char) when char in ?0..?9, do: true
  defp valid_char?(_), do: false

  defp coprime?(a, m), do: Integer.gcd(a, m) == 1

  defp modular_inverse(a, m) do
    {1, x, _} = Integer.extended_gcd(a, m)
    if x < 0, do: x + m, else: x
  end
end
