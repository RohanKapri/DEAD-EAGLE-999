defmodule TwoBucket do
  defstruct [:bucket_one, :bucket_two, :moves]
  @type t :: %TwoBucket{bucket_one: integer, bucket_two: integer, moves: integer}

  def new(size_one \\ 0, size_two \\ 0, moves \\ 0) do
    %TwoBucket{
      bucket_one: size_one,
      bucket_two: size_two,
      moves: moves
    }
  end

  @spec measure(
          size_one :: integer,
          size_two :: integer,
          goal :: integer,
          start_bucket :: :one | :two
        ) :: {:ok, TwoBucket.t()} | {:error, :impossible}
  def measure(size_one, size_two, goal, _) when size_one < goal and size_two < goal do
    {:error, :impossible}
  end

  def measure(size_one, size_two, goal, start_bucket) when goal == size_one do
    case start_bucket do
      :one -> {:ok, new(size_one, 0, 1)}
      :two -> {:ok, new(size_one, size_two, 2)}
    end
  end

  def measure(size_one, size_two, goal, start_bucket) when goal == size_two do
    case start_bucket do
      :one -> {:ok, new(size_one, size_two, 2)}
      :two -> {:ok, new(0, size_two, 1)}
    end
  end

  def measure(size_one, size_two, goal, start_bucket) do
    size = %{one: size_one, two: size_two}
    bucket = Map.put(%{one: 0, two: 0}, start_bucket, size[start_bucket])

    done? = fn bucket ->
      case bucket do
        %{one: ^goal, two: _} when start_bucket == :one -> true
        %{one: _, two: ^goal} when start_bucket == :two -> true
        %{one: one, two: ^goal} when one != 0 -> true
        %{one: ^goal, two: two} when two != 0 -> true
        %{one: _one, two: ^goal} -> true
        %{one: ^goal, two: _two} -> true
        _ -> false
      end
    end

    traverse(
      [bucket],
      MapSet.new([%{one: 0, two: 0}, %{one: size_one, two: size_two}]),
      size,
      done?,
      1
    )
  end

  defp traverse([], _, _, _, _), do: {:error, :impossible}

  defp traverse(buckets, seen, size, stop_condition, epoch) do
    if sol = solution(buckets, stop_condition) do
      {:ok, new(sol.one, sol.two, epoch)}
    else
      seen = MapSet.union(MapSet.new(buckets), seen)

      candidates =
        for(b <- buckets, into: [], do: transition(b, size))
        |> List.flatten()
        |> MapSet.new()
        |> MapSet.difference(seen)
        |> MapSet.to_list()

      traverse(candidates, seen, size, stop_condition, epoch + 1)
    end
  end

  defp solution(buckets, condition) do
    Enum.find(buckets, nil, &condition.(&1))
  end

  defp transition(buckets, sizes) do
    Enum.concat([
      pour(buckets, sizes),
      fill(buckets, sizes),
      empty(buckets, sizes)
    ])
  end

  defp pour(buckets, %{one: a, two: b}) do
    case buckets do
      %{one: x, two: y}
      when x + y <= a ->
        [
          %{one: 0, two: x + y},
          %{one: x + y, two: 0}
        ]

      %{one: x, two: y}
      when x + y > a and x + y <= b ->
        [
          %{one: 0, two: x + y},
          %{one: a, two: y - (a - x)}
        ]

      %{one: x, two: y}
      when x + y > b ->
        [
          %{one: x - (b - y), two: b},
          %{one: a, two: y - (a - x)}
        ]

      _ -> []
    end
  end

  defp fill(buckets, %{one: a, two: b}) do
    case buckets do
      %{one: 0, two: 0} -> [%{one: a, two: 0}, %{one: 0, two: b}]
      %{one: ^a, two: ^b} -> []
      %{one: ^a, two: 0} -> [%{one: a, two: b}]
      %{one: 0, two: ^b} -> [%{one: a, two: b}]
      %{one: x, two: 0} -> [%{one: x, two: b}]
      %{one: 0, two: y} -> [%{one: a, two: y}]
      _ -> []
    end
  end

  defp empty(buckets, %{one: a, two: b}) do
    case buckets do
      %{one: 0, two: 0} -> []
      %{one: ^a, two: ^b} -> [%{one: a, two: 0}, %{one: 0, two: b}]
      %{one: ^a, two: y} -> [%{one: 0, two: y}]
      %{one: ^a, two: 0} -> []
      %{one: x, two: ^b} -> [%{one: x, two: 0}]
      %{one: 0, two: ^b} -> []
      %{one: x, two: y} -> [%{one: x, two: 0}, %{one: 0, two: y}]
      _ -> []
    end
  end
end