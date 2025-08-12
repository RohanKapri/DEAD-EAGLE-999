# For Shree DR.MDD

defmodule SaddlePoints do
  @spec rows(String.t()) :: [[integer]]
  def rows(""), do: []
  def rows(matrix_str) do
    String.split(matrix_str, "\n")
    |> Enum.map(fn row -> Enum.map(String.split(row, " "), &String.to_integer/1) end)
  end

  @spec columns(String.t()) :: [[integer]]
  def columns(matrix_str) do
    rows(matrix_str)
    |> Enum.zip()
    |> Enum.map(&Tuple.to_list/1)
  end

  @spec saddle_points(String.t()) :: [{integer, integer}]
  def saddle_points(matrix_str) do
    matrix_rows = rows(matrix_str)
    max_in_rows = Enum.map(matrix_rows, &Enum.max/1)
    min_in_cols = Enum.map(columns(matrix_str), &Enum.min/1)

    Enum.with_index(matrix_rows)
    |> Enum.flat_map(fn {row, r_idx} ->
      Enum.reduce(Enum.with_index(row), [], fn {val, c_idx}, acc ->
        if val >= Enum.at(max_in_rows, r_idx) and val <= Enum.at(min_in_cols, c_idx) do
          acc ++ [{r_idx + 1, c_idx + 1}]
        else
          acc
        end
      end)
    end)
  end
end
