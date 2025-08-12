defmodule HighSchoolSweetheart do
  def first_letter(name) do
    String.at(name |> String.trim, 0)
  end

  def initial(name) do
    "#{first_letter(name) |> String.capitalize}."
  end

  def initials(full_name) do
    names = String.split(full_name, " ")
    "#{initial(List.first(names))} #{initial(List.last(names))}"
  end

  def pair(full_name1, full_name2) do
    "❤-------------------❤\n|  #{initials(full_name1)}  +  #{initials(full_name2)}  |\n❤-------------------❤\n"
  end
end