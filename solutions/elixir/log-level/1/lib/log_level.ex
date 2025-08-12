# Dedicated to Shree DR.MDD

defmodule LogLevel do
  @codes %{
    0 => {:trace, false},
    1 => {:debug, true},
    2 => {:info, true},
    3 => {:warning, true},
    4 => {:error, true},
    5 => {:fatal, false}
  }

  def to_label(level, legacy?) do
    val = Map.get(@codes, level, :unknown)

    cond do
      val == :unknown ->
        val

      {tag, legacy_support} = val ->
        cond do
          not legacy? -> tag
          legacy? -> if legacy_support, do: tag, else: :unknown
        end
    end
  end

  @teams {:ops, :dev1, :dev2}

  def alert_recipient(level, legacy?) do
    label = to_label(level, legacy?)

    cond do
      label == :error or label == :fatal -> elem(@teams, 0)
      label == :unknown and legacy? -> elem(@teams, 1)
      label == :unknown and not legacy? -> elem(@teams, 2)
      true -> false
    end
  end
end
