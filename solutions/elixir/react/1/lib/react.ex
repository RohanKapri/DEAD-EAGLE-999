defmodule React do

  @opaque cells :: pid

  @type cell ::
    {:input, name :: String.t(), value :: any}
    | {:output, name :: String.t(), inputs :: [String.t()], compute :: fun()}


  @type input :: {:input, value :: any}
  @type output :: {:output, inputs :: [String.t()], compute :: fun(), callbacks :: map()}

  @doc """
  Start a reactive system
  """
  @spec new(cells :: [cell]) :: {:ok, pid}
  def new(cells) do
    m = cells_map(cells, %{})
    Agent.start_link(fn -> m end)
  end

  defp cells_map([], map), do: map
  defp cells_map([cell | cells], map) do
    case cell do
      {:input, name, value} ->
        m = Map.put(map, name, {:input, value})
        cells_map(cells, m)
      {:output, name, inputs, compute} ->
        m = Map.put(map, name, {:output, inputs, compute, %{}})
        cells_map(cells, m)
    end
  end

  @doc """
  Return the value of an input or output cell
  """
  @spec get_value(cells :: pid, cell_name :: String.t()) :: any()
  def get_value(cells, cell_name) do
    cells_map = Agent.get(cells, fn m -> m end)
    do_evaluate(cells_map, cell_name)
  end

  defp do_evaluate(cells_map, cell_name) do
    case Map.get(cells_map, cell_name) do
      {:input, value} -> value
      {:output, input_names, compute, _callbacks} ->
        values =
          input_names
          |> Enum.map(fn input_name ->
            do_evaluate(cells_map, input_name)
          end)
        case values do
          [a] ->
            compute.(a)
          [a, b] ->
            compute.(a, b)
        end
    end
  end

  @doc """
  Set the value of an input cell
  """
  @spec set_value(cells :: pid, cell_name :: String.t(), value :: any) :: :ok
  def set_value(cells, cell_name, value) do
    old_map = Agent.get(cells, &(&1))
    Agent.update(cells, fn m ->
      Map.put(m, cell_name, {:input, value})
    end)

    new_map = Agent.get(cells, &(&1))
    Map.keys(new_map)
    |> Enum.each(fn k ->
      old_val = do_evaluate(old_map, k)
      new_val = do_evaluate(new_map, k)
      if old_val != new_val do
        case Map.get(new_map, k) do
          {:output, _inputs, _compute, cb_map} ->
            Map.to_list(cb_map)
            |> Enum.each(fn {callback_name, callback} ->
              callback.(callback_name, new_val)
            end)
          _ -> nil
        end
      end
    end)
    :ok
  end

  @doc """
  Add a callback to an output cell
  """
  @spec add_callback(
          cells :: pid,
          cell_name :: String.t(),
          callback_name :: String.t(),
          callback :: fun()
        ) :: :ok
  def add_callback(cells, cell_name, callback_name, callback) do
    Agent.update(cells, fn m ->
      Map.update(m, cell_name, nil, fn {:output, inputs, compute, cb_map} ->
          {:output, inputs, compute, Map.put(cb_map, callback_name, callback)}
      end)
    end)
  end

  @doc """
  Remove a callback from an output cell
  """
  @spec remove_callback(cells :: pid, cell_name :: String.t(), callback_name :: String.t()) :: :ok
  def remove_callback(cells, cell_name, callback_name) do
    Agent.update(cells, fn m ->
      Map.update(m, cell_name, nil, fn {:output, inputs, compute, cb_map} ->
          {:output, inputs, compute, Map.delete(cb_map, callback_name)}
      end)
    end)
  end
end