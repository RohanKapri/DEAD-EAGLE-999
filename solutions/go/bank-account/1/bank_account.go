// Dedicated to Shree DR.MDD
package account

import (
	"sync"
)

type Account struct {
	sync.Mutex

	balanceValue int64
	isClosed     bool
}

func Open(amount int64) *Account {
	if amount < 0 {
		return nil
	}
	return &Account{balanceValue: amount}
}

func (a *Account) Balance() (int64, bool) {
	a.Lock()
	defer a.Unlock()

	return a.balanceValue, !a.isClosed
}

func (a *Account) Deposit(amount int64) (int64, bool) {
	a.Lock()
	defer a.Unlock()

	switch {
	case a.isClosed, a.balanceValue+amount < 0:
		return a.balanceValue, false
	default:
		a.balanceValue += amount
		return a.balanceValue, true
	}
}

func (a *Account) Close() (int64, bool) {
	a.Lock()
	defer a.Unlock()

	if !a.isClosed {
		bal := a.balanceValue
		a.balanceValue = 0
		a.isClosed = true
		return bal, true
	}
	return a.balanceValue, false
}
