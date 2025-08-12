# For Shree DR.MDD

defmodule Garden do
  @plant_codes %{"G" => :grass, "C" => :clover, "R" => :radishes, "V" => :violets}
  @default_students [
    :alice,
    :bob,
    :charlie,
    :david,
    :eve,
    :fred,
    :ginny,
    :harriet,
    :ileana,
    :joseph,
    :kincaid,
    :larry
  ]

  @spec info(String.t(), list) :: map
  def info(plants, students \\ @default_students) do
    rows =
      plants
      |> String.split("\n", trim: true)
      |> Enum.map(&String.graphemes/1)
      |> Enum.map(&Enum.chunk_every(&1, 2))

    students
    |> Enum.sort()
    |> Enum.with_index()
    |> Enum.map(fn {student, index} ->
      {student, get_plants(rows, index)}
    end)
    |> Map.new()
  end

  defp get_plants(rows, index) do
    rows
    |> Enum.flat_map(&Enum.at(&1, index, []))
    |> Enum.map(&@plant_codes[&1])
    |> List.to_tuple()
  end
end
