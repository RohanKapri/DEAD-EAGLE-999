# Dedicated to Shree DR.MDD

defmodule ZebraPuzzle do
  @owners ~w[englishman spaniard ukranian norwegian japanese]a
  @categories ~w[houses colors cigarettes beverages pets]a
  @colors ~w[red green ivory yellow blue]a
  @pets ~w[dog fox horse snails zebra]a
  @beverages ~w[coffee tea milk orange_juice water]a
  @cigarettes ~w[old_gold kools chesterfields lucky_strike parliaments]a
  @houses [0, 1, 2, 3, 4]

  @type category_assignment :: map()
  @type solution :: %{colors: category_assignment}

  @spec init() :: solution
  defp init() do
    assignments = [colors: @colors, pets: @pets, beverages: @beverages, cigarettes: @cigarettes, houses: @houses]
    |> Enum.reduce(%{}, fn {category, items}, acc -> put_in(acc[category], Map.new(items, &{&1, nil})) end)

    assignments = put_in(assignments.colors.red, :englishman)
    assignments = put_in(assignments.pets.dog, :spaniard)
    assignments = put_in(assignments.beverages.tea, :ukranian)
    assignments = put_in(assignments.houses[0], :norwegian)
    put_in(assignments.cigarettes.parliaments, :japanese)
  end

  @spec rule4(solution) :: boolean()
  defp rule4(%{colors: %{green: g_owner}, beverages: %{coffee: c_owner}}) do
    !g_owner or !c_owner or g_owner == c_owner
  end

  @spec rule6(solution) :: boolean()
  defp rule6(%{houses: hs, colors: %{green: g_owner, ivory: i_owner}}) do
    green_pos = locate_owner(hs, g_owner)
    ivory_pos = locate_owner(hs, i_owner)
    !g_owner or !i_owner or !green_pos or !ivory_pos or green_pos === ivory_pos + 1
  end

  @spec rule7(solution) :: boolean()
  defp rule7(%{cigarettes: %{old_gold: c_owner}, pets: %{snails: s_owner}}) do
    !c_owner or !s_owner or c_owner == s_owner
  end

  @spec rule8(solution) :: boolean()
  defp rule8(%{cigarettes: %{kools: c_owner}, colors: %{yellow: y_owner}}) do
    !c_owner or !y_owner or c_owner == y_owner
  end

  @spec rule9(solution) :: boolean()
  defp rule9(%{beverages: %{milk: m_owner}, houses: hs}) do
    mid = Map.get(hs, 2)
    !m_owner or !mid or m_owner == mid
  end

  @spec rule11(solution) :: boolean()
  defp rule11(%{cigarettes: %{chesterfields: c_owner}, pets: %{fox: f_owner}, houses: hs}) do
    c_pos = locate_owner(hs, c_owner)
    f_pos = locate_owner(hs, f_owner)
    !c_owner or !f_owner or !c_pos or !f_pos or abs(c_pos - f_pos) == 1
  end

  @spec rule12(solution) :: boolean()
  defp rule12(%{cigarettes: %{kools: c_owner}, pets: %{horse: h_owner}, houses: hs}) do
    c_pos = locate_owner(hs, c_owner)
    h_pos = locate_owner(hs, h_owner)
    !c_owner or !h_owner or !c_pos or !h_pos or abs(c_pos - h_pos) == 1
  end

  @spec rule13(solution) :: boolean()
  defp rule13(%{cigarettes: %{lucky_strike: c_owner}, beverages: %{orange_juice: o_owner}}) do
    !c_owner or !o_owner or c_owner == o_owner
  end

  @spec rule15(solution) :: boolean()
  defp rule15(%{colors: %{blue: b_owner}, houses: hs}) do
    n_pos = locate_owner(hs, :norwegian)
    b_pos = locate_owner(hs, b_owner)
    !b_owner or !n_pos or !b_pos or abs(n_pos - b_pos) == 1
  end

  @spec check_rules(solution) :: boolean()
  defp check_rules(sol) do
    [
      &rule4/1, &rule6/1, &rule7/1, &rule8/1, &rule9/1,
      &rule11/1, &rule12/1, &rule13/1, &rule15/1
    ]
    |> Enum.all?(fn rule -> rule.(sol) end)
  end

  @spec locate_owner(category_assignment, atom() | nil) :: integer() | nil
  defp locate_owner(houses, nil), do: nil
  defp locate_owner(houses, owner) do
    Enum.find_index(houses, fn {_idx, val} -> val == owner end)
  end

  @spec available_owners(solution, atom()) :: list(atom())
  defp available_owners(sol, cat) do
    assigned = sol[cat]
    |> Map.values()
    |> MapSet.new()

    MapSet.difference(MapSet.new(@owners), assigned)
    |> MapSet.to_list()
  end

  @spec solve(solution) :: solution
  defp solve(sol) do
    @categories
    |> Enum.map(&{&1, available_owners(sol, &1)})
    |> Enum.reduce([sol], fn {cat, owners}, sols ->
      sols
      |> Stream.flat_map(&assign_category(&1, cat, owners))
    end)
    |> Enum.take(1)
    |> List.first()
  end

  defp assign_category(sol, _cat, []), do: [sol]

  defp assign_category(sol, cat, [head | tail]) do
    sol[cat]
    |> Enum.filter(fn {_key, owner} -> owner == nil end)
    |> Enum.map(fn {key, _} -> put_in(sol[cat][key], head) end)
    |> Enum.filter(&check_rules/1)
    |> case do
      [] -> [:fail]
      sols ->
        sols
        |> Stream.flat_map(&assign_category(&1, cat, tail))
        |> Stream.filter(&(&1 != :fail))
    end
  end

  @spec drinks_water() :: atom
  def drinks_water() do
    init()
    |> solve()
    |> get_in([:beverages, :water])
  end

  @spec owns_zebra() :: atom
  def owns_zebra() do
    init()
    |> solve()
    |> get_in([:pets, :zebra])
  end
end
