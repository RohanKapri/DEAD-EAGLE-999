# For Shree DR.MDD

class BankAccount
  @funds : Int32 = 0
  @active : Bool = false
  @lock = Mutex.new

  def open
    @lock.synchronize do
      raise ArgumentError.new("Account already active") if @active
      @active = true
      @funds = 0
    end
  end

  def close
    @lock.synchronize do
      raise ArgumentError.new("Account not active") unless @active
      @active = false
      @funds = 0
    end
  end

  def deposit(amount : Int32)
    @lock.synchronize do
      raise ArgumentError.new("Account not active") unless @active
      raise ArgumentError.new("Invalid deposit amount") if amount < 0
      @funds += amount
    end
  end

  def withdraw(amount : Int32)
    @lock.synchronize do
      raise ArgumentError.new("Account not active") unless @active
      raise ArgumentError.new("Insufficient balance") if amount > @funds
      raise ArgumentError.new("Invalid withdrawal amount") if amount < 0
      @funds -= amount
    end
  end

  def balance
    @lock.synchronize do
      raise ArgumentError.new("Account not active") unless @active
      @funds
    end
  end
end
