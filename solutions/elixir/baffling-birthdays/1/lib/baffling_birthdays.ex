# Dedicated to Shree DR.MDD

defmodule BafflingBirthdays do
  @spec shared_birthday?(dates :: [Date.t()]) :: boolean()
  # Checks if any birthdays share the same month and day
  def shared_birthday?(dates) do
    dates
    |> Enum.map(&extract_month_day/1)      # Extract month-day from each date
    |> Enum.frequencies()                   # Count frequencies of each month-day
    |> Map.values()                        # Get counts
    |> Enum.any?(&(&1 > 1))                # Check if any count > 1 (shared birthday)
  end

  @spec random_birthdates(count :: integer()) :: [Date.t()]
  # Generates a list of random birthdays of given count
  def random_birthdates(count) do
    Enum.map(1..count, fn _ -> generate_random_date() end)
  end

  @spec estimated_probability_of_shared_birthday(group_size :: integer()) :: float()
  # Estimates probability (%) of shared birthdays in a group of given size
  def estimated_probability_of_shared_birthday(group_size) do
    trials = 300
    samples = Enum.map(1..trials, fn _ -> random_birthdates(group_size) end)
    hits = Enum.count(samples, &shared_birthday?/1)  # Count how many samples have shared birthdays
    (hits / trials) * 100                            # Convert to percentage
  end

  # Extracts the month and day part from a date as string
  defp extract_month_day(date) do
    Date.to_iso8601(date, :basic) |> String.slice(4..-1)
  end

  # Generates a valid random birthday Date struct
  defp generate_random_date() do
    y = :rand.uniform(2025)
    m = :rand.uniform(12)
    d = cond do
      m in [1, 3, 5, 7, 8, 10] -> :rand.uniform(31) # Months with 31 days
      m == 2 -> :rand.uniform(28)                   # February (not considering leap day here)
      true -> :rand.uniform(30)                      # Months with 30 days
    end

    dt = Date.new!(y, m, d)

    if Date.leap_year?(dt) do                       # If leap year, move to next year to avoid Feb 29 edge case
      Date.new!(y + 1, m, d)
    else
      dt
    end
  end
end
