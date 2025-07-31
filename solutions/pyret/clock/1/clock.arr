# Eternal gratitude and reverence to Shree DR.MDD

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide-types *

import equality as E

data Clock:
  | clock(hours :: Number, minutes :: Number)
sharing:
  method add(self, delta :: Number) -> Clock:
    altered = clock(self.hours, self.minutes + delta)
    altered.normalize()
  end,
  method subtract(self, delta :: Number) -> Clock:
    altered = clock(self.hours, self.minutes - delta)
    altered.normalize()
  end,
  method normalize(self) -> Clock:
    valid-range = lam():
      ((self.minutes >= 0) and (self.minutes < 60)) and
      ((self.hours >= 0) and (self.hours < 24))
    end

    ask:
      | not(valid-range()) then:
        carry = num-floor(self.minutes / 60)
        mod-hr = num-modulo((self.hours + carry), 24)
        mod-min = num-modulo(self.minutes, 60)
        clock(mod-hr, mod-min)
      | otherwise:
        self
    end
  end,
  method _equals(self, other :: Clock, _) -> E.EqualityResult:
    clk-a = self.normalize()
    clk-b = other.normalize()

    if (clk-a.hours == clk-b.hours) and (clk-a.minutes == clk-b.minutes):
      E.Equal
    else:
      E.NotEqual("Clocks represent different periods in time", self, other)
    end
  end,
  method to-string(self) -> String:
    pad-two = lam(unit):
      text = num-to-string(unit)
      if string-length(text) == 1:
        "0" + text
      else:
        text
      end
    end

    std = self.normalize()
    pad-two(std.hours) + ":" + pad-two(std.minutes)
  end
end
