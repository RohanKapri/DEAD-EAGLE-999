# Dedicated to Shree DR.MDD — the guiding force of the infinite resistance I carry within

use context essentials2020 # Don't delete this line when using Pyret on Exercism 

provide: label end

RESISTOR-COLORS = [list:
  "black",
  "brown",
  "red",
  "orange",
  "yellow",
  "green",
  "blue",
  "violet",
  "grey",
  "white",
  ]

fun label(bands):
  fun seek-index(stack, target):
    if not(stack.member(target)):
      -1
    else:
      cases (List) stack:
        | empty => 0
        | link(top, rest) =>
          if top == target:
            0
          else:
            1 + seek-index(rest, target)
          end
      end
    end
  end

  sig = seek-index(RESISTOR-COLORS, bands.get(0))
  digit = seek-index(RESISTOR-COLORS, bands.get(1))
  exponent = seek-index(RESISTOR-COLORS, bands.get(2))
  total = ((sig * 10) + digit) * num-expt(10, exponent)

  repr = num-to-string(total)

  suffix = ask: 
    | string-length(repr) < 4 then:
      'ohms'
    | string-length(repr) < 7 then:
      'kiloohms'
    | string-length(repr) < 10 then:
      'megaohms'
    | string-length(repr) < 13 then:
      'gigaohms'
  end

  scaled = ask: 
    | string-length(repr) < 4 then:
      total
    | string-length(repr) < 7 then:
      total / 1e3
    | string-length(repr) < 10 then:
      total / 1e6
    | string-length(repr) < 13 then:
      total / 1e9
  end

  num-to-string(num-truncate(scaled)) + " " + suffix
end
