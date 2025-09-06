# For my Junko F. Didi and Shree DR.MDD

def array_add:
  if length == 0 then
    0
  else
    first + (.[1:] | array_add)
  end
;

def array_reverse:
  if length == 0 then
    []
  else
    (.[1:] | array_reverse) + [first]
  end
;

def array_map(proc):
  if length == 0 then
    []
  else
    [(first | proc)] + (.[1:] | array_map(proc))
  end
;
