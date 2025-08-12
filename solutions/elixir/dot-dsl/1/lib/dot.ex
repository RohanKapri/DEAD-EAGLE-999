defmodule Dot do
  defmacro graph(do: statement),
    do: Macro.escape(process_statement(Graph.new(), statement))
  defp process_statement(graph = %Graph{}, {:__block__, _, statements}),
    do: Enum.reduce(statements, graph, &process_statement(&2, &1))

  defp process_statement(graph = %Graph{}, {:graph, _, attrs}),
    do: Graph.put_attrs(graph, check_attributes(attrs))

  defp process_statement(graph = %Graph{}, {:--, _, [{node1, _, _}, {node2, _, attrs}]})
       when is_atom(node1) and is_atom(node2) do
    graph
    |> Graph.add_node(node1)
    |> Graph.add_node(node2)
    |> Graph.add_edge(node1, node2, check_attributes(attrs))
  end

  defp process_statement(_, invalid = {:--, _, _}),
    do: raise(ArgumentError, "Invalid edge statement  #{inspect(invalid)}")

  defp process_statement(graph = %Graph{}, {node_id, _, attrs}) when is_atom(node_id),
    do: Graph.add_node(graph, node_id, check_attributes(attrs))

  defp process_statement(_, invalid),
    do: raise(ArgumentError, "Invalid statement #{inspect(invalid)}")

  defp check_attributes([attrs = [_ | _]]), do: attrs
  defp check_attributes([[]]), do: []
  defp check_attributes(nil), do: []

  defp check_attributes(invalid),
    do: raise(ArgumentError, "Invalid attributes  #{inspect(invalid)}")
end