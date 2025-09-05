class BankAccountState {
  static opened { "opened" }
  static closed { "closed" }
}

class BankAccount {
  construct new() {
    _state = BankAccountState.closed
  }
  
  validate(ok) {
    if (!ok) Fiber.abort("Bank account error") 
  }
  
  balance { 
    validate(BankAccountState.opened == _state)
    return _balance 
  }
  
  changeBalance(change) { 
    validate(BankAccountState.opened == _state)
    _balance = _balance + change
    validate(_balance >= 0)
  }  

  open() { 
    validate(BankAccountState.closed == _state)
    _state = BankAccountState.opened
    _balance = 0.0
  }

  close() {
    validate(BankAccountState.opened == _state)
    _state = BankAccountState.closed
  }

  deposit(amount) {
    validate(amount >= 0)
    changeBalance(amount)
  }

  withdraw(amount) {
    validate(amount >= 0)
    changeBalance(-amount)
  }

}