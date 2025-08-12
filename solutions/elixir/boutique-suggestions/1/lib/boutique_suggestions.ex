defmodule BoutiqueSuggestions do
  @moduledoc false

  @max_price 100

  def get_combinations(tops, bottoms, options \\ []) do
    mprice = Keyword.get(options, :maximum_price, @max_price)

    for x <- tops,
        y <- bottoms,
        x.base_color != y.base_color,
        x.price + y.price <= mprice do
      {x, y}
    end
  end
end