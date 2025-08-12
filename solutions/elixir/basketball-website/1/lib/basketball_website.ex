defmodule BasketballWebsite do
  @moduledoc false

  @spec extract_from_path(map(), String.t()) :: any()
  def extract_from_path(data, path) do
    do_extract_from_path(data, String.split(path, "."))
  end

  defp do_extract_from_path(data, []), do: data
  defp do_extract_from_path(data, [h | t]) do
    do_extract_from_path(data[h], t)
  end

  @spec get_in_path(map(), String.t()) :: any()
  def get_in_path(data, path) do
    get_in(data, String.split(path, "."))
  end
end