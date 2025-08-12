defmodule RPNCalculator.Exception do
  @moduledoc false

  defmodule DivisionByZeroError do
    defexception message: "division by zero occurred"
  end

  defmodule StackUnderflowError do
    defexception message: "stack underflow occurred"

    @impl true
    def exception(value) do
      case value do
        [] -> %StackUnderflowError{}
        ctx -> %StackUnderflowError{message: "stack underflow occurred, context: #{ctx}"}
      end
    end
  end

  def divide(stack) when length(stack) < 2 do
    raise StackUnderflowError, "when dividing"
  end

  def divide([0, _]), do: raise(DivisionByZeroError)
  def divide([a, b]), do: div(b, a)
  def divide(_), do: raise(ArgumentError)
end