def popCount:
  . as [$num, $count]
  | if $num == 0 then
      $count
    else
      [($num / 2 | floor), $count + $num % 2] | popCount
    end
;
[.number, 0] | popCount