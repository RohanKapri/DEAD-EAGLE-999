defmodule BookStore do
  @typedoc "A book is represented by its number in the 5-book series"
  @type book :: 1 | 2 | 3 | 4 | 5

  @price_for_book 800
  @price_for_sets %{
    1 => @price_for_book,
    2 => 2 * @price_for_book * 0.95,
    3 => 3 * @price_for_book * 0.9,
    4 => 4 * @price_for_book * 0.8,
    5 => 5 * @price_for_book * 0.75
  }

  @doc """
  Calculate lowest price (in cents) for a shopping basket containing books.
  """
  @spec total(basket :: [book]) :: integer
  def total(basket) do
    basket
    |> increasing_counts_of_distinct_books()
    |> counts_by_setsize()
    |> recombine_sets_of_3_and_5_to_sets_of_4()
    |> Enum.reduce(
      0,
      fn {set_size, count_of_sets}, total -> total + count_of_sets * @price_for_sets[set_size] end
    )
  end

  defp increasing_counts_of_distinct_books(books),
    do: books |> Enum.frequencies() |> Map.values() |> Enum.sort()

  defp counts_by_setsize([]), do: %{}

  defp counts_by_setsize(incr_counts = [count | _]) do
    incr_counts
    |> Enum.map(&(&1 - count))
    |> Enum.reject(&(&1 == 0))
    |> counts_by_setsize()
    |> Map.put_new(Enum.count(incr_counts), count)
  end

  defp recombine_sets_of_3_and_5_to_sets_of_4(
         counts_by_setsize = %{5 => sets_of_5, 3 => sets_of_3}
       ) do
    recombinations = min(sets_of_5, sets_of_3)
    recombined_sets_of_4 = recombinations * 2

    counts_by_setsize
    |> Map.put(5, sets_of_5 - recombinations)
    |> Map.put(3, sets_of_3 - recombinations)
    |> Map.update(4, recombined_sets_of_4, &(&1 + recombined_sets_of_4))
  end

  defp recombine_sets_of_3_and_5_to_sets_of_4(counts_by_setsize), do: counts_by_setsize
end