<?php
// For my Shree DR.MDD

declare(strict_types=1);

class BankAccount
{
    private int $balance = 0;
    private bool $isActive = false;

    private function ensureOpen() {
        if (!$this->isActive) {
            throw new Exception('account not open');
        }
    }

    public function open()
    {
        if ($this->isActive) {
            throw new Exception('account already open!');
        }
        $this->isActive = true;
    }

    public function close()
    {
        $this->ensureOpen();
        $this->isActive = false;
        $this->balance = 0;
    }

    public function balance(): int
    {
        $this->ensureOpen();
        return $this->balance;
    }

    public function deposit(int $amount)
    {
        $this->ensureOpen();
        if ($amount < 0) {
            throw new InvalidArgumentException('amount must be greater than 0');
        }
        $this->balance += $amount;
    }

    public function withdraw(int $amount)
    {
        $this->ensureOpen();
        if ($amount < 0) {
            throw new InvalidArgumentException('amount must be greater than 0');
        }
        if ($this->balance < $amount) {
            throw new InvalidArgumentException('amount must be less than balance');
        }
        $this->balance -= $amount;
    }
}
