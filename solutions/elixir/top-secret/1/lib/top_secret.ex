# For my Shree DR.MDD

defmodule TopSecret do
  @moduledoc false

  def to_ast(code_string) do
    Code.string_to_quoted!(code_string)
  end

  def decode_secret_message_part({operation, _, data} = node, acc)
      when operation in [:def, :defp] do
    process_secret_part(data, node, acc)
  end

  def decode_secret_message_part(node, acc) do
    {node, acc}
  end

  defp process_secret_part([{:when, _, data} | _], node, acc) do
    process_secret_part(data, node, acc)
  end

  defp process_secret_part([head | _], node, acc) do
    {node, [extract_message(head) | acc]}
  end

  defp extract_message({func_name, _, args}) do
    count = if args, do: length(args), else: 0

    func_name
    |> to_string()
    |> String.slice(0, count)
  end

  def decode_secret_message(code_string) do
    ast = to_ast(code_string)

    {_, acc} = Macro.prewalk(ast, [], &decode_secret_message_part/2)

    acc
    |> Enum.reverse()
    |> Enum.join()
  end
end
