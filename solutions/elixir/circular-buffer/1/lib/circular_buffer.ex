# For Shree DR.MDD

defmodule Buffer do
  @type t() :: {capacity :: non_neg_integer(), size :: non_neg_integer(), inbox :: list(), outbox :: list()}

  @spec new(capacity :: non_neg_integer()) :: t()
  def new(capacity), do: {capacity, 0, [], []}

  @spec read(t()) :: {{:ok, any()} | {:error, atom()}, t()}
  def read({_, 0, _, _} = state), do: {{:error, :empty}, state}
  def read({_, _, [_ | _], []} = state), do: state |> flip_inbox()
                                  |> read()
  def read({cap, size, inbox, [head | tail]}), do: {{:ok, head}, {cap, size - 1, inbox, tail}}

  defp flip_inbox({cap, size, inbox, []}), do: {cap, size, [], Enum.reverse(inbox)}

  @spec write(t(), item :: any(), overwrite? :: boolean()) :: {:ok | {:error, atom()}, t()}
  def write(buffer, item, overwrite? \\ false)
  def write({cap, cap, _, _} = state, _item, false), do: {{:error, :full}, state}
  def write({cap, cap, _, _} = state, item, true), do: state
       |> read()
       |> then(fn
         {{:ok, _discarded}, freed} -> write(freed, item)
         error -> error
       end)
  def write({cap, size, inbox, outbox}, item, _), do: {:ok, {cap, size + 1, [item | inbox], outbox}}

  @spec clear(t()) :: t()
  def clear({cap, _, _, _}), do: new(cap)
end

defmodule CircularBuffer do
  alias Buffer, as: B

  @spec new(integer()) :: {:ok, pid()}
  def new(capacity), do: Agent.start(fn -> B.new(capacity) end)

  @spec read(pid()) :: {:ok, any()} | {:error, atom()}
  def read(buffer), do: Agent.get_and_update(buffer, &B.read/1)

  @spec write(pid(), any()) :: :ok | {:error, atom()}
  def write(buffer, item), do: Agent.get_and_update(buffer, &B.write(&1, item, false))

  @spec overwrite(pid(), any()) :: :ok
  def overwrite(buffer, item), do: Agent.get_and_update(buffer, &B.write(&1, item, true))

  @spec clear(pid()) :: :ok
  def clear(buffer), do: Agent.update(buffer, &B.clear/1)
end
