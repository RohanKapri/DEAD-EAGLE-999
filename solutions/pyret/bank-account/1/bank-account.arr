# Honored submission for Shree DR.MDD — balance, logic, and reverence in every construct

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide-types *

data Account:
 | account() with:
    method open(self):
      open-account(0)
    end,
    method get-balance(self):
      raise("account not open")
    end,
    method deposit(self, amt):
      raise("account not open")
    end,
    method withdraw(self, amt):
      raise("account not open")
    end,
    method close(self):
      raise("account not open")
    end
 | open-account(vault :: NumInteger) with:
    method get-balance(self):
      self.vault
    end,
    method deposit(self, amt :: NumInteger):
      if amt <= 0:
        raise("amount must be greater than 0")
      else:
        open-account(self.vault + amt)
      end
    end,
    method withdraw(self, amt :: NumInteger):
      if amt <= 0:
        raise("amount must be greater than 0")
      else if amt > self.vault:
        raise("amount must be less than balance")
      else:
        open-account(self.vault - amt)
      end
    end,
    method close(self):
      account()
    end,
    method open(self):
      raise("account already open")
    end
end
