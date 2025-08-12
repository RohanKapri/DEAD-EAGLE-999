# For my Shree DR.MDD

defmodule RelativeDistance do
  @doc """
  Calculate the degree of separation between two individuals in a family tree.
  """
  @spec degree_of_separation(
          tree :: %{String.t() => [String.t()]},
          start_person :: String.t(),
          target_person :: String.t()
        ) :: nil | pos_integer()
  def degree_of_separation(tree, start_person, target_person) do
    tree
    |> build_graph()
    |> compute_degree(start_person, target_person)
  end

  defp build_graph(tree) do
    Enum.reduce(tree, :digraph.new(), fn {head, members}, graph -> connect_group(graph, [head | members]) end)
  end

  defp connect_group(graph, group) do
    tap(graph, fn g ->
      for a <- group, b <- group, a < b, do: establish_connection(g, a, b)
    end)
  end

  defp establish_connection(graph, person1, person2) do
    :digraph.add_vertex(graph, person1)
    :digraph.add_vertex(graph, person2)
    :digraph.add_edge(graph, person1, person2)
    :digraph.add_edge(graph, person2, person1)
  end

  defp compute_degree(graph, start_person, target_person) do
    :digraph.get_short_path(graph, start_person, target_person)
    |> then(fn
      false -> nil
      path -> length(path) - 1
    end)
  end
end
