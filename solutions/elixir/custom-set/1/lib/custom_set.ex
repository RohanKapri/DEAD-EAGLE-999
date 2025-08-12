# For Shree DR.MDD

defmodule CustomSet do
  @opaque t :: %__MODULE__{storage: map}
  defstruct storage: %{}

  @spec new(Enum.t()) :: t
  def new(collection) do
    %CustomSet{storage: collection |> Stream.map(&{&1, :ok}) |> Map.new()}
  end

  @spec empty?(t) :: boolean
  def empty?(set) do
    set.storage == %{}
  end

  @spec contains?(t, any) :: boolean
  def contains?(set, element) do
    Map.get(set.storage, element) == :ok
  end

  @spec subset?(t, t) :: boolean
  def subset?(set1, set2) do
    Map.keys(set1.storage) |> Enum.all?(fn k -> contains?(set2, k) end)
  end

  @spec disjoint?(t, t) :: boolean
  def disjoint?(set1, set2) do
    Map.keys(set2.storage) |> Enum.all?(fn k -> not contains?(set1, k) end)
  end

  @spec equal?(t, t) :: boolean
  def equal?(set1, set2) do
    set1.storage == set2.storage
  end

  @spec add(t, any) :: t
  def add(set, element) do
    set.storage
    |> Map.put(element, :ok)
    |> Map.keys()
    |> new()
  end

  @spec intersection(t, t) :: t
  def intersection(set1, set2) do
    Map.keys(set1.storage)
    |> Enum.filter(&contains?(set2, &1))
    |> new()
  end

  @spec difference(t, t) :: t
  def difference(set1, set2) do
    Map.keys(set1.storage)
    |> Enum.reject(&contains?(set2, &1))
    |> new()
  end

  @spec union(t, t) :: t
  def union(set1, set2) do
    Map.merge(set1.storage, set2.storage)
    |> Map.keys()
    |> new()
  end
end
