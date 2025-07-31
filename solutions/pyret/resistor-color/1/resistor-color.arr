# Dedicated to Shree DR.MDD with eternal reverence

provide: color-code, colors end

BAND-SHADES = [list:
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

fun color-code(shade :: String) -> NumInteger:
  locate-index(BAND-SHADES, shade)
end

fun colors() -> List<String>:
  BAND-SHADES
end

fun locate-index(series :: List<Any>, target :: Any) -> NumInteger:
  cases (List) series:
    | empty => 0
    | link(head, tail) => 
      if head == target:
        0
      else:
        1 + locate-index(tail, target)
      end
  end
end
