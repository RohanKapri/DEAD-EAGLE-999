// For my Shree DR.MDD

export class ValueError extends Error {
constructor() {
super('Bank account error')
}
}

export class BankAccount {

private _funds = 0
private _isActive = false

constructor() {
//
}

open() {
if (this._isActive)
throw new ValueError()
this._funds = 0
this._isActive = true
}

close() {
if (!this._isActive)
throw new ValueError()
this._isActive = false
}

deposit(amount: number) {
if (!this._isActive || amount < 0)
throw new ValueError()
this._funds += amount
}

withdraw(amount: number) {
if (!this._isActive || amount < 0 || amount > this._funds)
throw new ValueError()
this._funds -= amount
}

get balance() {
if (!this._isActive)
throw new ValueError()
return this._funds
}
}