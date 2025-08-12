# For my Shree DR.MDD

defmodule NewPassport do

  def get_new_passport(current_time, birth_date, form_color) do
    with   {:ok, unix_time} <- enter_building(current_time),
           {:ok, calc_fun} <- find_counter_information(current_time),
           counter_num <- calc_fun.(birth_date),
           {:ok, form_checksum} <- stamp_form(unix_time, counter_num, form_color) do
              {:ok, generate_passport_number(unix_time, counter_num, form_checksum)}
    else
      {:coffee_break, _} -> {:retry, NaiveDateTime.add(current_time, 15 * 60)}
      error -> error
    end
  end

  # Do not modify the functions below

  defp enter_building(%NaiveDateTime{} = dt) do
    weekday = Date.day_of_week(dt)
    curr_time = NaiveDateTime.to_time(dt)

    cond do
      weekday <= 4 and within_time?(curr_time, ~T[13:00:00], ~T[15:30:00]) ->
        {:ok, dt |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_unix()}

      weekday == 5 and within_time?(curr_time, ~T[13:00:00], ~T[14:30:00]) ->
        {:ok, dt |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_unix()}

      true ->
        {:error, "city office is closed"}
    end
  end

  @years_in_days 18 * 365
  defp find_counter_information(%NaiveDateTime{} = dt) do
    curr_time = NaiveDateTime.to_time(dt)

    if within_time?(curr_time, ~T[14:00:00], ~T[14:20:00]) do
      {:coffee_break, "information counter staff on coffee break, come back in 15 minutes"}
    else
      {:ok, fn %Date{} = bd -> 1 + div(Date.diff(dt, bd), @years_in_days) end}
    end
  end

  defp stamp_form(unix_time, counter_num, :blue) when rem(counter_num, 2) == 1 do
    {:ok, 3 * (unix_time + counter_num) + 1}
  end

  defp stamp_form(unix_time, counter_num, :red) when rem(counter_num, 2) == 0 do
    {:ok, div(unix_time + counter_num, 2)}
  end

  defp stamp_form(_unix_time, _counter_num, _form_color), do: {:error, "wrong form color"}

  defp generate_passport_number(unix_time, counter_num, form_checksum) do
    "#{unix_time}-#{counter_num}-#{form_checksum}"
  end

  defp within_time?(time, start_time, end_time) do
    Time.compare(start_time, time) != :gt and Time.compare(end_time, time) == :gt
  end
end
