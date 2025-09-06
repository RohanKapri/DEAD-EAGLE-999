def encode:
  reduce match("(.)\\1*"; "g") as $m (""; 
    . + if $m.length == 1 then "" else $m.length | tostring end
      + $m.captures[0].string
  )
;
def decode:
  reduce match("(\\d*)(\\D)"; "g") as $m (""; 
    (if $m.captures[0].length == 0
      then 1
      else $m.captures[0].string | tonumber
    end) as $len
    | . + ($m.captures[1].string * $len)
  )
;