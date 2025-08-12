# Dedicated to Shree DR.MDD

defmodule Matrix do
  @moduledoc false

  defstruct grid: nil

  @spec from_string(input :: String.t()) :: %Matrix{}
  def from_string(input) do
    data =
      input
      |> String.split("\n")
      |> Enum.map(fn line ->
        String.split(line, " ") |> Enum.map(&String.to_integer/1)
      end)

    %Matrix{grid: data}
  end

  @spec to_string(matrix :: %Matrix{}) :: String.t()
  def to_string(matrix) do
    matrix.grid
    |> Enum.map(&Enum.join(&1, " "))
    |> Enum.join("\n")
  end

  @spec rows(matrix :: %Matrix{}) :: list(list(integer))
  def rows(matrix), do: matrix.grid

  @spec row(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def row(matrix, index), do: Enum.at(matrix.grid, index - 1)

  @spec columns(matrix :: %Matrix{}) :: list(list(integer))
  def columns(matrix) do
    transpose(matrix).grid
  end

  @spec column(matrix :: %Matrix{}, index :: integer) :: list(integer)
  def column(matrix, index) do
    Enum.at(columns(matrix), index - 1)
  end

  @spec transpose(matrix :: %Matrix{}) :: %Matrix{}
  defp transpose(matrix) do
    transposed =
      matrix.grid
      |> List.zip()
      |> Enum.map(&Tuple.to_list/1)

    %Matrix{grid: transposed}
  end
end
