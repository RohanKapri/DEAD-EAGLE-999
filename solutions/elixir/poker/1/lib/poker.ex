defmodule Poker do
  @moduledoc false

  @ranks ~w(2 3 4 5 6 7 8 9 10 J Q K A)
  @suits ~w(C D H S)
  @rank_ace 14
  @cards_by_string for {rank_string, index_rank} <- Enum.zip(@ranks, 2..@rank_ace),
                       suit <- @suits,
                       into: %{},
                       do: {rank_string <> suit, {index_rank, suit}}

  @doc """
  Given a list of poker hands, return a list containing the highest scoring hand.

  If two or more hands tie, return the list of tied hands in the order they were received.

  Example hand: ~w(4S 5H 4C 5D 4H) # Full house, 5s over 4s
  """
  @spec best_hand(list(list(String.t()))) :: list(list(String.t()))
  def best_hand(hands) do
    hands
    |> Enum.map(&{value(&1), &1})
    |> Enum.sort(:desc)
    |> then(fn
      sorted_by_value = [{highest_value, _} | _] ->
        sorted_by_value
        |> Enum.take_while(fn {value, _cards} -> value == highest_value end)
        |> Enum.map(&elem(&1, 1))
    end)
  end

  # This is the main business logic, determining the value of a hand
  #
  # Since poker is only about relative value, not about points, the value is
  # only needed for the sole purpose for easy comparing.
  #
  # For this purpose, the value is a list of ordinal numbers in descending pririty,
  # e.g. [2, rank_of_pair | other_ranks]: 2 is the second lowest hand (a single pair),
  # the rank of the pair is determining which hand with a single pair wins.
  # The descending other ranks of the single cards are further tie breakers
  defp value(hand) do
    # the value of a hand is determined by the highest/first matching properties
    case properties_of_hand(hand) do
      %{:flush => _suit, 1 => [r5, r4, r3, r2, r1]}
      when r1 == r2 - 1 and r2 == r3 - 1 and r3 == r4 - 1 and r4 == r5 - 1 ->
        # straight_flush
        [9, r5]

      %{:flush => _suit, 1 => [@rank_ace, 5, 4, 3, 2]} ->
        # straight_flush, special case with Ace as 1
        [9, 5]

      %{4 => [rank_of_quartet], 1 => other_ranks} ->
        # 4 of a kind
        [8, rank_of_quartet | other_ranks]

      %{3 => [rank_of_triple], 2 => [rank_of_pair]} ->
        # full house
        [7, rank_of_triple, rank_of_pair]

      %{:flush => _suit, 1 => descending_ranks_of_same_suit} ->
        # flush
        [6, descending_ranks_of_same_suit]

      %{1 => [r5, r4, r3, r2, r1]}
      when r1 == r2 - 1 and r2 == r3 - 1 and r3 == r4 - 1 and r4 == r5 - 1 ->
        # straight
        [5, r5]

      %{1 => [@rank_ace, 5, 4, 3, 2]} ->
        # straight, special case with Ace as 1
        [5, 5]

      %{3 => [rank_of_triple], 1 => other_ranks} ->
        # three of a kind
        [4, rank_of_triple | other_ranks]

      %{2 => [rank_of_higher_pair, rank_of_lower_pair], 1 => other_ranks} ->
        # 2 pairs
        [3, rank_of_higher_pair, rank_of_lower_pair | other_ranks]

      %{2 => [rank_of_pair], 1 => other_ranks} ->
        # pair
        [2, rank_of_pair | other_ranks]

      %{1 => descending_ranks} ->
        # high card; this is the least matching property, therefore we need no _ case
        [1 | descending_ranks]
    end
  end

  # extract a map of value-relevant properties from the hand
  defp properties_of_hand(hand) do
    hand
    |> Enum.map(&Map.get(@cards_by_string, &1))
    |> then(fn cards ->
      cards
      |> descending_ranks_by_cardinality()
      |> may_add_flush_suit(cards)
    end)
  end

  # Main criteria for the value of a poker hand are groups of 4,3,2,1 cards and their ranks
  # e.g. %{2 => [11, 6], 1 => [14]} means pairs of Jacks and 6s, the remaining card is an ace
  defp descending_ranks_by_cardinality(cards) do
    cards
    |> Enum.map(&elem(&1, 0))
    |> Enum.frequencies()
    |> Enum.reduce(%{}, fn {rank, count}, map -> Map.update(map, count, [rank], &[rank | &1]) end)
  end

  # Another criterion (flush) indicates that all cards have the same suit (elem 1 in the card tuple)
  defp may_add_flush_suit(map, [{_, s}, {_, s}, {_, s}, {_, s}, {_, s}]),
    do: Map.put(map, :flush, s)

  defp may_add_flush_suit(map, _), do: map
end