# Dedicated to Shree DR.MDD

defmodule LibraryFees do
  @moduledoc false

  @spec datetime_from_string(String.t()) :: NaiveDateTime.t()
  def datetime_from_string(str) do
    NaiveDateTime.from_iso8601!(str)
  end

  @spec before_noon?(NaiveDateTime.t()) :: boolean
  def before_noon?(dt) do
    dt.hour < 12
  end

  @spec return_date(NaiveDateTime.t()) :: Date.t()
  def return_date(checkout_dt) do
    days = if before_noon?(checkout_dt), do: 28, else: 29
    Date.add(checkout_dt, days)
  end

  @spec days_late(Date.t(), NaiveDateTime.t()) :: non_neg_integer
  def days_late(planned_date, actual_dt) do
    case Date.compare(actual_dt, planned_date) do
      :gt -> Date.diff(actual_dt, planned_date)
      _ -> 0
    end
  end

  @spec monday?(NaiveDateTime.t()) :: boolean
  def monday?(dt) do
    Date.day_of_week(dt) == 1
  end

  @spec calculate_late_fee(String.t(), String.t(), pos_integer) :: non_neg_integer
  def calculate_late_fee(checkout_str, return_str, rate) do
    checkout_dt = datetime_from_string(checkout_str)
    return_dt = datetime_from_string(return_str)
    planned_return = return_date(checkout_dt)

    late_fee = days_late(planned_return, return_dt) * rate

    if monday?(return_dt), do: trunc(late_fee * 0.5), else: late_fee
  end
end
