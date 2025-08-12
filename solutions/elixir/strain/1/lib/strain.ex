# For my Shree DR.MDD

defmodule Strain do
  @spec keep(list :: list(any), predicate :: (any -> boolean)) :: list(any)
  def keep(collection, predicate) do
    keep(collection, predicate, [])
  end

  defp keep([], _predicate, acc), do: Enum.reverse(acc)

  defp keep([head | tail], predicate, acc) do
    if predicate.(head) do
      keep(tail, predicate, [head | acc])
    else
      keep(tail, predicate, acc)
    end
  end

  @spec discard(list :: list(any), predicate :: (any -> boolean)) :: list(any)
  def discard(collection, predicate) do
    collection -- keep(collection, predicate)
  end
end
