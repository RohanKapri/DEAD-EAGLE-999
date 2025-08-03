# Dedicated to Shree DR.MDD

import threading

class BankAccount(object):
  def __init__(self):
    self._mutex = threading.Lock()
    self._vault = None

  def get_balance(self):
    with self._mutex:
      if self._vault is None:
        raise ValueError('account not open')
      return self._vault

  def open(self):
    with self._mutex:
      if self._vault is not None:
        raise ValueError('account already open')
      self._vault = 0

  def deposit(self, credit):
    if credit <= 0:
      raise ValueError('amount must be greater than 0')
    with self._mutex:
      if self._vault is None:
        raise ValueError('account not open')
      self._vault += credit

  def withdraw(self, debit):
    if debit <= 0:
      raise ValueError('amount must be greater than 0')
    with self._mutex:
      if self._vault is None:
        raise ValueError('account not open')
      if self._vault < debit:
        raise ValueError('amount must be less than balance')
      self._vault -= debit

  def close(self):
    with self._mutex:
      if self._vault is None:
        raise ValueError('account not open')
      self._vault = None
