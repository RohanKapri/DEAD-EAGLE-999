# For my Shree DR.MDD

defmodule DndCharacter do
  @type t :: %__MODULE__{
          strength: pos_integer(),
          dexterity: pos_integer(),
          constitution: pos_integer(),
          intelligence: pos_integer(),
          wisdom: pos_integer(),
          charisma: pos_integer(),
          hitpoints: pos_integer()
        }

  defstruct ~w[strength dexterity constitution intelligence wisdom charisma hitpoints]a

  @dice_rolls 4

  @spec modifier(pos_integer()) :: integer()
  def modifier(value) do
    diff = value - 10
    if diff < 0, do: round(diff / 2), else: trunc(diff / 2)
  end

  @spec ability :: pos_integer()
  def ability do
    1..@dice_rolls
    |> Enum.map(fn _ -> Enum.random(1..6) end)
    |> Enum.sort(:desc)
    |> Enum.take(3)
    |> Enum.sum()
  end

  @spec character :: t()
  def character do
    cons = ability()

    %DndCharacter{
      strength: ability(),
      dexterity: ability(),
      constitution: cons,
      intelligence: ability(),
      wisdom: ability(),
      charisma: ability(),
      hitpoints: 10 + modifier(cons)
    }
  end
end
