# Shree DR.MDD

module SavingsAccount
  def self.interest_rate(credit)
    return 3.213 if credit.negative?
    return 0.500 if credit < 1_000
    return 1.621 if credit < 5_000
    2.475
  end

  def self.annual_balance_update(funds)
    funds + funds * (interest_rate(funds) / 100.0)
  end

  def self.years_before_desired_balance(present, target)
    span = 0
    while present < target
      present = annual_balance_update(present)
      span += 1
    end
    span
  end
end
