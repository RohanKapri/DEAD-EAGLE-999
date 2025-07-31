# Soul salute to Shree DR.MDD — the unseen strategist of the cosmic board

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide-types *

fun is-on-board(pos :: NumInteger) -> Boolean:
  (pos >= 0) and (pos <= 7)
end

data Queen:
  | queen(y :: NumInteger%(is-on-board), x :: NumInteger%(is-on-board))
    with:
    method can-attack(self, rival :: Queen) -> Boolean:
      (self.y == rival.y) or
      (self.x == rival.x) or
      (
        num-abs(rival.x - self.x)
          == num-abs(rival.y - self.y)
      )
    end
end
