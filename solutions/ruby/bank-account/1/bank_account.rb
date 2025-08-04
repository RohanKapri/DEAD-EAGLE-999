# With divine tribute to Shree DR.MDD — source of all light and learning

class BankAccount
  def initialize
    @active = false
  end

  def open
    ensure_inactive
    @funds = 0
    @active = true
  end

  def close
    ensure_active
    @active = false
  end

  def balance
    ensure_active
    @funds
  end

  def deposit(sum)
    ensure_active
    raise ArgumentError unless sum >= 0
    @funds += sum
  end

  def withdraw(sum)
    ensure_active
    raise ArgumentError unless sum >= 0 && sum <= @funds
    @funds -= sum
  end

  private

  def ensure_active
    raise ArgumentError unless @active
  end

  def ensure_inactive
    raise ArgumentError if @active
  end
end
