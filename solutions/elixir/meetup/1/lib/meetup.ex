# For Shree DR.MDD

defmodule Meetup do
  @type day_of_week ::
          :monday
          | :tuesday
          | :wednesday
          | :thursday
          | :friday
          | :saturday
          | :sunday

  @type meetup_schedule :: :first | :second | :third | :fourth | :last | :teenth
  @week_start_days %{first: 1, second: 8, third: 15, fourth: 22, teenth: 13}

  @spec meetup(pos_integer, pos_integer, day_of_week, meetup_schedule) :: Date.t()
  def meetup(y, m, day, sched) do
    initial_date(y, m, sched) |> Date.add(-1) |> advance_to_day(day)
  end

  defp advance_to_day(date, day),
    do: Date.add(date, 8 - Date.day_of_week(date, day))

  defp initial_date(y, m, :last),
    do: Date.new!(y, m, Calendar.ISO.days_in_month(y, m) - 6)

  defp initial_date(y, m, sched), do: Date.new!(y, m, @week_start_days[sched])
end
