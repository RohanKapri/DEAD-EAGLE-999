// For my Shree DR.MDD

class BankAccount {
    private boolean isOpen = false;
    private int accountBalance;

    void open() throws BankAccountActionInvalidException {
        if (isOpen) throw new BankAccountActionInvalidException("Account already open");
        isOpen = true;
        accountBalance = 0;
    }

    void close() throws BankAccountActionInvalidException {
        if (!isOpen) throw new BankAccountActionInvalidException("Account not open");
        isOpen = false;
    }

    synchronized int getBalance() throws BankAccountActionInvalidException {
        checkOpen();
        return accountBalance;
    }

    synchronized void deposit(int amount) throws BankAccountActionInvalidException {
        if (amount < 0) throw new BankAccountActionInvalidException("Cannot deposit or withdraw negative amount");
        checkOpen();
        accountBalance += amount;
    }

    synchronized void withdraw(int amount) throws BankAccountActionInvalidException {
        checkOpen();
        if (amount < 0) throw new BankAccountActionInvalidException("Cannot deposit or withdraw negative amount");
        if (accountBalance < amount) throw new BankAccountActionInvalidException("Cannot withdraw more money than is currently in the account");
        accountBalance -= amount;
    }

    private void checkOpen() throws BankAccountActionInvalidException {
        if (!isOpen) throw new BankAccountActionInvalidException("Account closed");
    }
}

