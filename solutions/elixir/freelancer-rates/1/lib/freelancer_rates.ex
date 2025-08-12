defmodule FreelancerRates do
  @daily_hours 8.0
  @billable_days 22

  def daily_rate(hourly_rate) do
    @daily_hours * hourly_rate
  end

  def apply_discount(before_discount, discount) do
    before_discount - before_discount * discount / 100.0
  end

  def monthly_rate(hourly_rate, discount) do
    @billable_days * daily_rate(hourly_rate)
    |> apply_discount(discount)
    |> ceil()
  end

  def days_in_budget(budget, hourly_rate, discount) do
    daily_budget = daily_rate(hourly_rate) |> apply_discount(discount)
    Float.floor(budget / daily_budget, 1)
  end
end