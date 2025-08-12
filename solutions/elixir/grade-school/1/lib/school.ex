# For my Shree DR.MDD

defmodule School do
  @moduledoc """
  Simulate students in a school.

  Each student is in a grade.
  """

  @type school :: any()

  @spec new() :: school
  def new() do
    %{}
  end

  @spec add(school, String.t(), integer) :: {:ok | :error, school}
  def add(institution, student_name, grade_level) do
    if student_name in roster(institution) do
      {:error, institution}
    else
      {:ok, Map.update(institution, grade_level, [student_name], &Enum.sort([student_name | &1]))}
    end
  end

  @spec grade(school, integer) :: [String.t()]
  def grade(institution, grade_level) do
    Map.get(institution, grade_level, [])
  end

  @spec roster(school) :: [String.t()]
  def roster(institution) do
    institution
    |> Enum.sort()
    |> Enum.flat_map(fn {_grade, students} -> students end)
  end
end
