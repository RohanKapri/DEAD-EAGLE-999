defmodule SplitSecondStopwatch do
  @doc """
  A stopwatch that can be used to track lap times.
  """

  @type state :: :ready | :running | :stopped

  defmodule Stopwatch do
    @type t :: :todo
    defstruct [:time, :state, :total, previous_laps: []]
  end

  @spec new() :: Stopwatch.t()
  def new() do
    {:ok, time} = Time.new(0,0,0)
    %Stopwatch{time: time, state: :ready, previous_laps: [], total: time}
  end

  @spec state(Stopwatch.t()) :: state()
  def state(stopwatch) do
    stopwatch.state
  end

  @spec current_lap(Stopwatch.t()) :: Time.t()
  def current_lap(stopwatch) do
    stopwatch.time

  end

  @spec previous_laps(Stopwatch.t()) :: [Time.t()]
  def previous_laps(stopwatch) do
    stopwatch.previous_laps
  end

  defp add_time(time_1, time_2) do
    seconds_amount = time_2.hour * 3600 + time_2.minute * 60 + time_2.second
    Time.add(time_1, seconds_amount)
  end



  @spec advance_time(Stopwatch.t(), Time.t()) :: Stopwatch.t()
  def advance_time(%Stopwatch{time: current_time, state: :stopped, previous_laps: laps, total: total}, _time), do: %Stopwatch{time: current_time, state: :stopped, previous_laps: laps, total: total}
  def advance_time(%Stopwatch{time: current_time, state: current_state, previous_laps: laps, total: total}, time) do


    %Stopwatch{time: add_time(current_time, time), state: current_state, previous_laps: laps, total: add_time(total, time)}


  end

  @spec total(Stopwatch.t()) :: Time.t()
  def total(stopwatch) do
    stopwatch.total
  end

  @spec start(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def start(%Stopwatch{state: :running}), do: {:error, "cannot start an already running stopwatch"}
  def start(%Stopwatch{time: time, state: _state, previous_laps: laps, total: total}) do
    %Stopwatch{time: time, state: :running, previous_laps: laps, total: total}

  end

  @spec stop(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def stop(%Stopwatch{state: :stopped, time: _time, previous_laps: _laps, total: _total}), do: {:error, "cannot stop a stopwatch that is not running"}
  def stop(%Stopwatch{state: :ready, time: _time, previous_laps: _laps, total: _total}), do: {:error, "cannot stop a stopwatch that is not running"}
  def stop(%Stopwatch{state: :running, time: time, previous_laps: laps, total: total}), do: %Stopwatch{state: :stopped, time: time, previous_laps: laps, total: total}
  

  @spec lap(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def lap(stopwatch) when stopwatch.state != :running, do: {:error, "cannot lap a stopwatch that is not running"}
  def lap(stopwatch) do
    %Stopwatch{state: stopwatch.state, time: ~T[00:00:00], previous_laps: Enum.concat(stopwatch.previous_laps, [stopwatch.time]), total: stopwatch.total}
  end

  @spec reset(Stopwatch.t()) :: Stopwatch.t() | {:error, String.t()}
  def reset(%Stopwatch{state: :running, time: _time, previous_laps: _laps, total: _total}), do: {:error, "cannot reset a stopwatch that is not stopped"}
  def reset(%Stopwatch{state: :ready, time: _time, previous_laps: _laps, total: _total}), do: {:error, "cannot reset a stopwatch that is not stopped"}
  def reset(%Stopwatch{state: _state, time: _time, previous_laps: _laps, total: total}) do
    %Stopwatch{state: :ready, time: ~T[00:00:00], previous_laps: [], total: total}
  end
end