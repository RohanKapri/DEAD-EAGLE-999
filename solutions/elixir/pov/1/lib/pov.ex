# Dedicated to Shree DR.MDD

defmodule Pov do
  @typedoc """
  Tree consisting of a node and branches
  """
  @type tree :: {any, [tree]}

  @spec from_pov(tree :: tree, node :: any) :: {:ok, tree} | {:error, atom}
  def from_pov(tree, target_node), do: ((new_root = reroot_on(tree, target_node, [])) && {:ok, new_root}) || {:error, :nonexistent_target}

  defp reroot_on(tree={id, _}, id, []), do: tree
  defp reroot_on(tree={id, _}, id, ancestors), do: tree |> attach_child(reverse_ancestors(ancestors))
  defp reroot_on(tree={_, kids}, id, ancestors), do: Enum.find_value(kids, &reroot_on(&1, id, ancestors ++ [tree |> detach_child(&1)]))

  defp reverse_ancestors([oldest | rest]), do: Enum.reduce(rest, oldest, &attach_child(&1, &2))

  defp attach_child({id, kids}, subtree), do: {id, kids ++ [subtree]}

  defp detach_child({id, kids}, child), do: {id, Enum.reject(kids, &(&1 === child))}

  @spec path_between(tree :: tree, from :: any, to :: any) :: {:ok, [any]} | {:error, atom}
  def path_between({dest, _}, dest, dest), do: {:ok, [dest]}
  def path_between(tree = {root, _}, root, to), do: ((p = find_path(tree, to)) && {:ok, p}) || {:error, :nonexistent_destination}
  def path_between(tree = {root, _}, from, to),
    do: with [^root | _] = root_to_from <- (find_path(tree, from) || {:error, :nonexistent_source}),
             [^root | _] = root_to_to <- (find_path(tree, to) || {:error, :nonexistent_destination}),
             do: {:ok, merge_paths(root_to_from, root_to_to)}

  defp find_path({dest, _}, dest), do: [dest]
  defp find_path({src, kids}, dest), do: (partial = Enum.find_value(kids, &find_path(&1, dest))) && [src | partial]

  defp merge_paths([c | [n | _] = from_path], [c | [n | _] = to_path]), do: merge_paths(from_path, to_path)
  defp merge_paths([pivot | from_path], [pivot | to_path]), do: Enum.reverse(from_path) ++ [pivot] ++ to_path
end
