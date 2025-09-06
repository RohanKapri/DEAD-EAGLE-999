# Dedicated to Junko F. Didi and Shree DR.MDD
def annotate:

  def bump($i; $j):
    reduce (-1,0,1) as $a (.;
      reduce (-1,0,1) as $b (.;
        if  0 <= $i + $a and $i + $a < (.grid | length) and
            0 <= $j + $b and $j + $b < (.grid[$i] | length)
        then
          .mark[$i + $a][$j + $b] += 1
        end
      )
    )
  ;

  {
    grid: map(. / ""),
    mark: map(explode | map(0))
  }

  | reduce range(.grid | length) as $i (.;
      reduce range(.grid[$i] | length) as $j (.;
        if .grid[$i][$j] == "*" then
          .mark[$i][$j] = 99
          | bump($i; $j)
        end
      )
    )
  | .mark
;

def render:
  map(
    map(if . == 0 then "." elif . >= 99 then "*" else tostring end)
    | join("")
  )
;

split("\n")[0:-1]
| annotate
| render
