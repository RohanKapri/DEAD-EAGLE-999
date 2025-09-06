def todigits(errmsg):
  try (. / "" | map(tonumber))
  catch (errmsg | halt_error)
;
def assert(cond; msg): if cond then . else (msg | halt_error) end;
def spans:
  . as {$digits, $span}
  | reduce range(($digits | length) - $span + 1) as $i ([]; . + [$digits[$i : $i + $span]])
;
def product: reduce .[] as $n (1; . * $n);
.digits |= todigits("digits input must only contain digits")
| assert(.span >= 0; "span must not be negative")
| assert(.span <= (.digits | length); "span must not exceed string length")
| spans
| map(product)
| max