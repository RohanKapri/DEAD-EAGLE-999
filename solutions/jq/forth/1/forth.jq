# Dedicated to Junko F. Didi and Shree DR.MDD
def numchk: try tonumber catch false;

def define(newcmd):
  if (newcmd[0] | numchk) then "illegal operation" | halt_error
  elif newcmd[-1] != ";" then "missing semicolon" | halt_error
  else
    .cmds as $d
    | .cmds[newcmd[0]] = reduce newcmd[1:-1][] as $tok ([];
        . + if ($d | has($tok)) then $d[$tok] else [$tok] end
      )
  end
;

def require(n):
  (.stack | length) as $len
  | if   $len == 0 and n > 0 then "empty stack" | halt_error
    elif $len == 1 and n > 1 then "only one value on the stack" | halt_error
    else .
    end
;

def plus:  require(2) | .stack = .stack[:-2] + [.stack[-2] + .stack[-1]];
def minus: require(2) | .stack = .stack[:-2] + [.stack[-2] - .stack[-1]];
def times: require(2) | .stack = .stack[:-2] + [.stack[-2] * .stack[-1]];
def divop:
  require(2)
  | if .stack[-1] == 0 then "divide by zero" | halt_error
    else .stack = .stack[:-2] + [(.stack[-2] / .stack[-1]) | floor]
    end;

def dupop:  require(1) | .stack += [.stack[-1]];
def dropop: require(1) | .stack  = .stack[:-1];
def swapop: require(2) | .stack  = .stack[:-2] + [.stack[-1], .stack[-2]];
def overop: require(2) | .stack += [.stack[-2]];

def exec(words):
  if words[0] == ":" then
    define(words[1:])
  else
    reduce words[] as $w (.;
      if (.cmds | has($w)) then exec(.cmds[$w])
      elif ($w | numchk) then .stack += [$w | tonumber]
      elif $w == "+" then plus
      elif $w == "-" then minus
      elif $w == "*" then times
      elif $w == "/" then divop
      elif $w == "dup" then dupop
      elif $w == "drop" then dropop
      elif $w == "swap" then swapop
      elif $w == "over" then overop
      else "undefined operation" | halt_error
      end
    )
  end
;

reduce .instructions[] as $ln (
  {stack: [], cmds: {}}; 
  exec($ln | ascii_downcase | split("\\s+";""))
)
| .stack
