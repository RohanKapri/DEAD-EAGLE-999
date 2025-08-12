defmodule LinkedList do
  @opaque t :: tuple()

  @doc """
  Construct a new LinkedList
  """
  @spec new() :: t
  def new() do
    {:ok, nil, nil}
  end

  @doc """
  Push an item onto a LinkedList
  """
  @spec push(t, any()) :: t
  def push(list, elem) do
    case list do
      {:ok, nil, _} -> {:ok, elem, {:ok, nil, nil}}
      {:ok, _, _} -> {:ok, elem, list}
    end
  end

  @doc """
  Calculate the length of a LinkedList
  """
  @spec count(t) :: non_neg_integer()
  def count(list), do: count(list, 0)

  defp count({:ok, nil, nil}, len), do: len
  defp count({:ok, _, rest}, len), do: count(rest, len + 1)

  @doc """
  Determine if a LinkedList is empty
  """
  @spec empty?(t) :: boolean()
  def empty?({:ok, nil, _}), do: true
  def empty?({:ok, _, _}), do: false

  @doc """
  Get the value of a head of the LinkedList
  """
  @spec peek(t) :: {:ok, any()} | {:error, :empty_list}
  def peek(list) do
    case elem(list, 1) do
      nil -> {:error, :empty_list}
      value -> {:ok, value}
    end
  end

  @doc """
  Get tail of a LinkedList
  """
  @spec tail(t) :: {:ok, t} | {:error, :empty_list}
  def tail(list) do
    case elem(list, 2) do
      nil -> {:error, :empty_list}
      l -> {:ok, l}
    end
  end

  @doc """
  Remove the head from a LinkedList
  """
  @spec pop(t) :: {:ok, any(), t} | {:error, :empty_list}
  def pop(list) do
    case elem(list, 1) do
      nil -> {:error, :empty_list}
      _ -> list
    end
  end

  @doc """
  Construct a LinkedList from a stdlib List
  """
  @spec from_list(list()) :: t
  def from_list(list) do
    list
    |> Enum.reverse()
    |> Enum.reduce(LinkedList.new(), &push(&2, &1))
  end

  @doc """
  Construct a stdlib List LinkedList from a LinkedList
  """
  @spec to_list(t) :: list()
  def to_list(list) do
    to_list(list, [])
  end

  defp to_list(list, acc) do
    case pop(list) do
      {:error, :empty_list} -> Enum.reverse(acc)
      {:ok, elem, tail} -> to_list(tail, [elem | acc])
    end
  end

  @doc """
  Reverse a LinkedList
  """
  @spec reverse(t) :: t
  def reverse(list) do
    list
    |> to_list()
    |> Enum.reverse()
    |> from_list()
  end
end