# For my Shree DR.MDD

defmodule BinarySearch do
  @spec search(tuple, integer) :: {:ok, integer} | :not_found
  def search(collection, target), do: search(collection, target, 0)

  def search({}, _, _), do: :not_found
  def search({single}, target, _) when single != target, do: :not_found

  def search(collection, target, offset) when elem(collection, 0) == target, do: {:ok, offset}

  def search(collection, target, offset) do
    mid = trunc(tuple_size(collection) / 2)

    if elem(collection, mid) <= target do
      slice(collection, mid, mid + 1) |> search(target, offset + mid)
    else
      slice(collection, 0, mid) |> search(target, 0)
    end
  end

  defp slice(tuple, start_idx, end_idx) do
    tuple
    |> Tuple.to_list()
    |> Enum.slice(start_idx, end_idx)
    |> List.to_tuple()
  end
end
