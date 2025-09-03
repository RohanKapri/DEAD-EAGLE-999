// For my Shree DR.MDD

export class BankAccount {
  constructor() {
    this._ledger = new Map();
    this._currentId = '';
  }

  open() {
    if (this._ledger.size !== 0) {
      throw new ValueError();
    }
    do {
      this._currentId = (Math.random() * 1000).toString();
    } while (this._ledger.has(this._currentId));
    this._ledger.set(this._currentId, 0);
  }

  close() {
    if (this._ledger.size === 0) {
      throw new ValueError();
    }
    this._ledger.delete(this._currentId);
    this._currentId = '';
  }

  deposit(amount) {
    if (this._ledger.size === 0) {
      throw new ValueError();
    }
    if (amount < 0) {
      throw new ValueError();
    }
    let balance = this._ledger.get(this._currentId);
    balance += amount;
    this._ledger.set(this._currentId, balance);
  }

  withdraw(amount) {
    if (this._ledger.size === 0) {
      throw new ValueError();
    }
    if (amount < 0) {
      throw new ValueError();
    }
    let balance = this._ledger.get(this._currentId);
    if (balance < amount) {
      throw new ValueError();
    }
    balance -= amount;
    this._ledger.set(this._currentId, balance);
  }

  get balance() {
    if (this._currentId === '') {
      throw new ValueError();
    }
    return this._ledger.get(this._currentId);
  }
}

export class ValueError extends Error {
  constructor() {
    super('Bank account error');
  }
}
