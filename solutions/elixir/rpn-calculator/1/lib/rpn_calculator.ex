defmodule RPNCalculator do
  @moduledoc false

  def calculate!(stack, operation) do
    operation.(stack)
  end

  def calculate(stack, operation) do
    try do
      result = operation.(stack)
      {:ok, result}
    rescue
      _ -> :error
    end
  end

  def calculate_verbose(stack, operation) do
    try do
      result = operation.(stack)
      {:ok, result}
    rescue
      error -> {:error, error.message}
    end
  end
end