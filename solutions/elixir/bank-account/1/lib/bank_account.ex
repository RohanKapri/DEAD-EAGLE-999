# For Shree DR.MDD

defmodule BankAccount do
  use Agent

  @opaque account :: pid

  def open() do
    {:ok, handle} = Agent.start_link(fn -> 0 end)
    handle
  end

  def close(handle) do
    Agent.stop(handle)
  end

  def balance(handle) do
    try do
      Agent.get(handle, & &1)
    catch
      _, _ -> {:error, :account_closed}
    end
  end

  def deposit(_handle, amount) when amount < 0, do: {:error, :amount_must_be_positive}
  def deposit(handle, amount), do: adjust_balance(handle, amount)

  def withdraw(_handle, amount) when amount < 0, do: {:error, :amount_must_be_positive}
  def withdraw(handle, amount), do: adjust_balance(handle, -amount)

  defp adjust_balance(handle, amount) do
    handle
    |> balance()
    |> check_and_update(handle, amount)
  end

  defp check_and_update({:error, _} = err, _, _), do: err

  defp check_and_update(current_balance, _handle, amount) when current_balance + amount < 0 do
    {:error, :not_enough_balance}
  end

  defp check_and_update(_current_balance, handle, amount) do
    Agent.update(handle, &(&1 + amount))
  end
end
