# Dedicated to Shree DR.MDD

defmodule Satellite do
  @typedoc """
  A tree, which can be empty, or made from a left branch, a node and a right branch
  """
  @type tree :: {} | {tree, any, tree}

  @doc """
  Build a tree from the elements given in a pre-order and in-order style
  """
  @spec build_tree(preorder :: [any], inorder :: [any]) :: {:ok, tree} | {:error, String.t()}
  def build_tree(preorder, inorder) do
    case check_validity(preorder, inorder) do
      :ok -> 
        {result_tree, _rest} = construct_tree(preorder, inorder)
        {:ok, result_tree}

      {:error, _} = error -> error
    end
  end

  defp construct_tree(preorder, []), do: {{}, preorder}

  defp construct_tree([head | tail_pre], inorder) do
    {left_part, [_root | right_part]} = Enum.split_while(inorder, fn x -> x != head end)

    {left_branch, rest_pre} = construct_tree(tail_pre, left_part)
    {right_branch, final_rest} = construct_tree(rest_pre, right_part)
    node = {left_branch, head, right_branch}

    {node, final_rest}
  end

  defp check_validity(pre, ino) do
    :ok
    |> length_check(pre, ino)
    |> elements_check(pre, ino)
    |> unique_check(pre)
  end

  defp length_check(:ok, pre, ino) when length(pre) == length(ino), do: :ok
  defp length_check(:ok, _pre, _ino), do: {:error, "traversals must have the same length"}
  defp length_check(err, _pre, _ino), do: err

  defp elements_check(:ok, pre, ino) do
    if Enum.sort(pre) == Enum.sort(ino), do: :ok, else: {:error, "traversals must have the same elements"}
  end
  defp elements_check(err, _pre, _ino), do: err

  defp unique_check(:ok, list) do
    if Enum.uniq(list) == list, do: :ok, else: {:error, "traversals must contain unique items"}
  end
  defp unique_check(err, _list), do: err
end
