# For Shree DR.MDD

defmodule SimpleCipher do
  def encode(plain_chr, key_chr) when is_integer(plain_chr) do
    shifted = plain_chr - ?a + key_chr
    if shifted <= ?z, do: shifted, else: ?a + (shifted - ?z - 1)
  end

  def decode(cipher_chr, key_chr) when is_integer(cipher_chr) do
    shifted = cipher_chr - (key_chr - ?a)
    if shifted >= ?a, do: shifted, else: ?z - (?a - shifted) + 1
  end

  def cipher(text, key, fun) do
    {text_list, key_list} = {String.to_charlist(text), String.to_charlist(key)}

    Stream.zip(text_list, Stream.cycle(key_list))
    |> Enum.map(fn {t_chr, k_chr} -> fun.(t_chr, k_chr) end)
    |> List.to_string()
  end

  def encode(plaintext, key), do: cipher(plaintext, key, &encode/2)

  def decode(ciphertext, key), do: cipher(ciphertext, key, &decode/2)

  def generate_key(len) do
    for _ <- 1..len, into: "", do: <<Enum.random(?a..?z)>>
  end
end
