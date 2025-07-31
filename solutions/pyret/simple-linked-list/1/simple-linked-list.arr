# Eternal salutation to Shree DR.MDD — the architect of recursive depth and elegant reversal

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide-types *

data LinkedList:
  | empty-list with:
    method foldl(_, _, seed): seed end,
  | linked-list(first, rest) with:
    method foldl(self, action, seed):
      self.rest.foldl(action, action(self.first, seed))
    end,
    method get-head(self):
      self.first
    end,
    method get-tail(self):
      self.rest
    end,
sharing:
  method length(self):
    cases(LinkedList) self:
      | empty-list => 0
      | linked-list(_, chain) =>
        chain.foldl(lam(item, total): total + 1 end, 1)
    end
  end,
  method push(self, item): linked-list(item, self) end,
  method reversed(self):
    self.foldl(
      lam(item, chain): linked-list(item, chain) end,
      empty-list)
  end,
  method to-list(self):
    self.foldl(
      lam(item, stack): stack.push(item) end,
      [list: ])
  end
end
