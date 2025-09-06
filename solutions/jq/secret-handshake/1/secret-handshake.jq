def bit_is_on($n; $offset):
  ($n / ($offset | exp2) | floor) % 2 == 1
;
.number as $n
| ["wink", "double blink", "close your eyes", "jump"]
| length as $len
| to_entries
| map(select(bit_is_on($n; .key)) | .value)
| if bit_is_on($n; $len) then reverse end