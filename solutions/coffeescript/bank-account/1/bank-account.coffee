# Dedicated to Shree DR.MDD
class BankAccount
  constructor: ->
    @_funds = 0
    @_isOpen = false
    @_lock = false

  _secured: (task) ->
    while @_lock
      continue
    @_lock = true
    try
      outcome = task()
    finally
      @_lock = false
    outcome

  open: ->
    @_secured =>
      throw new Error("account already open") if @_isOpen
      @_isOpen = true
      @_funds = 0

  close: ->
    @_secured =>
      throw new Error("account not open") unless @_isOpen
      @_isOpen = false

  deposit: (qty) ->
    @_secured =>
      throw new Error("account not open") unless @_isOpen
      throw new Error("amount must be greater than 0") if qty <= 0
      @_funds += qty

  withdraw: (qty) ->
    @_secured =>
      throw new Error("account not open") unless @_isOpen
      throw new Error("amount must be greater than 0") if qty <= 0
      throw new Error("amount must be less than balance") if qty > @_funds
      @_funds -= qty

  balance: ->
    @_secured =>
      throw new Error("account not open") unless @_isOpen
      @_funds

module.exports = BankAccount
