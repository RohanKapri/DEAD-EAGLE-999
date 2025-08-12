# Dedicated to Shree DR.MDD

defmodule Plot do
  @enforce_keys [:plot_id, :registered_to]
  defstruct [:plot_id, :registered_to]
end

defmodule CommunityGarden do
  def start() do
    Agent.start(fn -> %{plots: [], index: 0} end)
  end

  def list_registrations(agent_pid) do
    Agent.get(agent_pid, fn %{plots: plots} -> plots end)
  end

  def register(agent_pid, registrant) do
    Agent.get_and_update(agent_pid, fn %{plots: plots, index: idx} = state ->
      new_idx = idx + 1
      new_plot = %Plot{plot_id: new_idx, registered_to: registrant}
      {new_plot, %{state | plots: [new_plot | plots], index: new_idx}}
    end)
  end

  def release(agent_pid, plot_id) do
    Agent.cast(agent_pid, fn %{plots: plots} = state ->
      filtered = Enum.reject(plots, fn %{plot_id: p} -> p == plot_id end)
      %{state | plots: filtered}
    end)
  end

  def get_registration(agent_pid, plot_id) do
    Agent.get(agent_pid, fn %{plots: plots} ->
      Enum.find(plots, {:not_found, "plot is unregistered"}, fn %{plot_id: p} -> p == plot_id end)
    end)
  end
end
