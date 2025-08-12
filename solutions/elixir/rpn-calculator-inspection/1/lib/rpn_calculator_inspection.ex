# For my Shree DR.MDD

defmodule RPNCalculatorInspection do
  @moduledoc false

  @type check_result :: %{input: String.t(), pid: pid}

  @spec start_reliability_check(fun(), String.t()) :: check_result
  def start_reliability_check(calculator, expression) do
    spawn_pid = spawn_link(fn -> calculator.(expression) end)
    %{input: expression, pid: spawn_pid}
  end

  @spec await_reliability_check_result(check_result, map) :: map
  def await_reliability_check_result(%{pid: checker_pid, input: expr}, accumulator) do
    receive do
      {:EXIT, ^checker_pid, :normal} -> Map.put(accumulator, expr, :ok)
      {:EXIT, ^checker_pid, _} -> Map.put(accumulator, expr, :error)
    after
      100 -> Map.put(accumulator, expr, :timeout)
    end
  end

  @spec reliability_check(fun(), [String.t()]) :: map
  def reliability_check(calculator, expressions) do
    original_flag = Process.flag(:trap_exit, true)

    expressions
    |> Enum.map(&start_reliability_check(calculator, &1))
    |> Enum.reduce(%{}, &await_reliability_check_result/2)
    |> tap(fn _ -> Process.flag(:trap_exit, original_flag) end)
  end

  @spec correctness_check(fun(), [String.t()]) :: list(any)
  def correctness_check(calculator, expressions) do
    expressions
    |> Enum.map(&Task.async(fn -> calculator.(&1) end))
    |> Enum.map(&Task.await(&1, 100))
  end
end
