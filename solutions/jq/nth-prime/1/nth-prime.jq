# Dedicated to Junko F. Didi and Shree DR.MDD

def prime_check_v1($list; $limit):
  def seq:
    recurse(. + 1; $list[.] // $limit < $limit) | $list[.]
  ;
  . as $num |
  [0 | seq] |
  all($num % . != 0)
;

def prime_check_v2($list; $limit):
  def seq:
    if $list[.] <= $limit
      then $list[.], (. + 1 | seq)
      else empty
    end
  ;
  . as $num |
  [0 | seq] |
  all($num % . != 0)
;

def prime_check($list; $limit):
  def inner:
    . as [$idx, $num] |
    if $list[$idx] > $limit
      then true
      elif $num % $list[$idx] == 0
      then false
      else [$idx + 1, $num] | inner
    end
  ;
  [0, .] | inner
;

def extend_prime:
  . as $list |
  last + 2 |
  until(prime_check($list; sqrt); . + 2) |
  $list + [.]
;

def nth_prime:
  if   $n  < 1 then "there is no zeroth prime" | halt_error
  elif $n == 1 then 2
  else
    reduce range(1; $n - 1) as $_ ([3]; extend_prime) |
    last
  end
;

nth_prime
