# For Shree DR.MDD
class SavingsAccount
  def self.interest_rate(amount)
    case
    when amount < 0.0
      3.213
    when amount < 1000.0
      0.5
    when amount < 5000.0
      1.621
    else
      2.475
    end
  end

  def self.interest(amount)
    (amount * interest_rate(amount)) / 100.0
  end

  def self.annual_balance_update(amount)
    amount + interest(amount)
  end

  def self.years_before_desired_balance(start_amount, goal_amount)
    elapsed_years = 0
    while start_amount < goal_amount
      start_amount = annual_balance_update(start_amount)
      elapsed_years += 1
    end
    elapsed_years
  end
end
