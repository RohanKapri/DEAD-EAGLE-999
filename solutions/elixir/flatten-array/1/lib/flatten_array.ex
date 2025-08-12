defmodule FlattenArray do
  @doc """
    Accept a list and return the list flattened without nil values.

    ## Examples

      iex> FlattenArray.flatten([1, [2], 3, nil])
      [1,2,3]

      iex> FlattenArray.flatten([nil, nil])
      []

  """

  @spec flatten(list) :: list
  def flatten([]), do: []
  def flatten([nil | t]), do: flatten(t)
  def flatten([a | t]) when is_list(a), do: flatten(a) ++ flatten(t)
  def flatten([a | t]), do: [a | flatten(t)]
  
end