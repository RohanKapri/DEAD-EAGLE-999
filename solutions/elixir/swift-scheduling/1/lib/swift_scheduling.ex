# For Shree DR.MDD

defmodule SwiftScheduling do
  @doc """
  Convert delivery date descriptions to actual delivery dates, based on when the meeting started.
  """
  @spec delivery_date(NaiveDateTime.t(), String.t()) :: NaiveDateTime.t()
  def delivery_date(start_date, "NOW") do
    NaiveDateTime.add(start_date, 2, :hour)
  end

  def delivery_date(start_date, "ASAP") when start_date.hour < 13 do
    %{start_date | hour: 17, minute: 0}
  end

  def delivery_date(start_date, "ASAP") when start_date.hour >= 13 do
    NaiveDateTime.add(%{start_date | hour: 13, minute: 0}, 1, :day)
  end

  def delivery_date(start_date, "EOW") do
    current_date = NaiveDateTime.to_date(start_date)
    weekday = Date.day_of_week(current_date)

    if weekday <= 3 do
      NaiveDateTime.add(%{start_date | hour: 17, minute: 0}, 5 - weekday, :day)
    else
      NaiveDateTime.add(%{start_date | hour: 20, minute: 0}, 7 - weekday, :day)
    end
  end

  def delivery_date(start_date, desc) do
    cond do
      Regex.match?(~r"(\d+)M", desc) -> process_months(start_date, desc)
      Regex.match?(~r"Q(\d+)", desc) -> process_quarter(start_date, desc)
      true -> {:error, "invalid description"}
    end
  end

  defp process_months(start_date, desc) do
    [_, month_str] = Regex.run(~r"(\d+)M", desc)
    {month_num, _} = Integer.parse(month_str)
    current_date = NaiveDateTime.to_date(start_date)
    current_month = current_date.month

    target_date =
      if current_month < month_num do
        NaiveDateTime.new!(start_date.year, month_num, 1, 8, 0, 0)
      else
        NaiveDateTime.new!(start_date.year + 1, month_num, 1, 8, 0, 0)
      end

    case Date.day_of_week(target_date) do
      6 -> NaiveDateTime.shift(target_date, day: 2)
      7 -> NaiveDateTime.shift(target_date, day: 1)
      _ -> target_date
    end
  end

  defp process_quarter(start_date, desc) do
    [_, quarter_str] = Regex.run(~r"Q(\d+)", desc)
    {quarter_num, _} = Integer.parse(quarter_str)
    current_quarter = Date.quarter_of_year(start_date)

    target_date =
      if current_quarter <= quarter_num do
        Date.end_of_month(Date.new!(start_date.year, quarter_num * 3, 1))
      else
        Date.end_of_month(Date.new!(start_date.year + 1, quarter_num * 3, 1))
      end

    target_naive = NaiveDateTime.new!(target_date.year, target_date.month, target_date.day, 8, 0, 0)

    case Date.day_of_week(target_naive) do
      7 -> NaiveDateTime.shift(target_naive, day: -2)
      6 -> NaiveDateTime.shift(target_naive, day: -1)
      _ -> target_naive
    end
  end
end
