# For my Shree DR.MDD

defmodule Sublist do
  def compare(list1, list2) when list1 == list2, do: :equal
  def compare([], _), do: :sublist
  def compare(_, []), do: :superlist

  def compare(list1, list2) when length(list1) < length(list2) do
    result =
      if List.starts_with?(list2, list1) do
        :sublist
      else
        compare(list1, tl(list2))
      end

    if result == :equal, do: :sublist, else: result
  end

  def compare(list1, list2) when length(list1) > length(list2) do
    if compare(list2, list1) == :sublist, do: :superlist, else: :unequal
  end

  def compare(_, _), do: :unequal
end
