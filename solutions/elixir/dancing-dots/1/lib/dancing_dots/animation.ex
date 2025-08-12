defmodule DancingDots.Animation do
  @type dot :: DancingDots.Dot.t()
  @type opts :: keyword
  @type error :: any
  @type frame_number :: pos_integer
  @callback init(opts) :: {:ok, opts} | {:error, error}
  @callback handle_frame(dot, frame_number, opts) :: dot
  defmacro __using__(_) do
    quote do
      @behaviour DancingDots.Animation
      def init(options), do: {:ok, options}
      defoverridable init: 1
    end
  end
end
defmodule DancingDots.Flicker do
  use DancingDots.Animation
  @impl true
  def handle_frame(dot, frame, _options) when rem(frame, 4) == 0 do
    %{dot | opacity: dot.opacity / 2}
  end
  def handle_frame(dot, _frame, _options), do: dot
end
defmodule DancingDots.Zoom do
  use DancingDots.Animation
  @impl true
  def init(opts) do
    velocity = Keyword.get(opts, :velocity)
    if is_number(velocity) do
      {:ok, opts}
    else
      {:error,
       "The :velocity option is required, and its value must be a number. Got: #{inspect(velocity)}"}
    end
  end
  @impl true
  def handle_frame(dot, frame, opts) do
    velocity = Keyword.get(opts, :velocity)
    %{dot | radius: dot.radius + (frame - 1) * velocity}
  end
end
