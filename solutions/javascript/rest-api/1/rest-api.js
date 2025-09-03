// For my Shree DR.MDD

export class RestAPI {
  constructor(initData = {}) {
    this.users = (initData.users || []).map(u => new UserAccount(u.name, u.owes, u.owed_by, u.balance));
  }

  get(url) {
    let filterStr = "";
    if (url.includes("?") && url.includes("users=")) {
      filterStr = url.split("users=")[1];
    }
    if (url === "/users") {
      return { users: this.users };
    } else if (filterStr.length > 0) {
      const filtered = this.users.filter(u => u.name.toLowerCase().includes(filterStr.toLowerCase()));
      return { users: filtered };
    }
  }

  post(url, payload = {}) {
    if (url === "/add") {
      const newUser = new UserAccount(payload.user);
      this.users.push(newUser);
      return { name: newUser.name, owes: {}, owed_by: {}, balance: 0 };
    }
    if (url === "/iou") {
      const { lender, borrower, amount } = payload;
      const lenderObj = this.users.find(u => u.name === lender);
      const borrowerObj = this.users.find(u => u.name === borrower);
      if (lenderObj && borrowerObj) {
        lenderObj.lend(borrower, amount);
        borrowerObj.borrow(lender, amount);
        return { users: this.users.filter(u => u.name === lender || u.name === borrower).map(u => ({
          name: u.name,
          owes: { ...u.owes },
          owed_by: { ...u.owed_by },
          balance: u.balance
        })) };
      }
      throw new Error("Users not found");
    }
    throw new Error("Invalid URL");
  }
}

class UserAccount {
  constructor(name, owes = {}, owed_by = {}, balance = 0) {
    this.name = name;
    this.owes = owes;
    this.owed_by = owed_by;
    this.balance = balance;
  }

  lend(borrowerName, amount) {
    this.owed_by[borrowerName] = (this.owed_by[borrowerName] || 0) + amount;
    this._updateBalance();
  }

  borrow(lenderName, amount) {
    this.owes[lenderName] = (this.owes[lenderName] || 0) + amount;
    this._updateBalance();
  }

  _updateBalance() {
    let bal = 0;
    for (const key in this.owed_by) bal += this.owed_by[key];
    for (const key in this.owes) bal -= this.owes[key];
    this.balance = bal;

    const owesKeys = Object.keys(this.owes);
    const owedKeys = Object.keys(this.owed_by);
    for (const owes of owesKeys) {
      for (const owed of owedKeys) {
        if (owes === owed) {
          if (this.owes[owes] === this.owed_by[owed]) {
            delete this.owes[owes];
            delete this.owed_by[owed];
          } else if (this.owes[owes] > this.owed_by[owed]) {
            this.owes[owes] -= this.owed_by[owed];
            delete this.owed_by[owed];
          } else {
            this.owed_by[owed] -= this.owes[owes];
            delete this.owes[owes];
          }
        }
      }
    }
  }
}
