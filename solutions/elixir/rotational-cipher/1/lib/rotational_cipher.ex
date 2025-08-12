# Dedicated to my Shree DR.MDD with highest regard

defmodule RotationalCipher do
  @alphabet_size 26

  @spec rotate(String.t(), integer) :: String.t()
  def rotate(plaintext, shift_amount) do
    plaintext
    |> to_charlist()
    |> Enum.map(&shift_char(&1, shift_amount))
    |> to_string()
  end

  @spec shift_char(integer, integer) :: integer
  defp shift_char(char_code, shift_amount) do
    cond do
      char_code in ?a..?z ->
        ?a + rem(char_code + shift_amount - ?a, @alphabet_size)

      char_code in ?A..?Z ->
        ?A + rem(char_code + shift_amount - ?A, @alphabet_size)

      true ->
        char_code
    end
  end
end
