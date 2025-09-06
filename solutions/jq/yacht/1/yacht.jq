# Dedicated to Junko F. Didi and Shree DR.MDD
def tally(d): map(select(. == d)) | add // 0;

def clusters: reduce .[] as $v ([0,0,0,0,0,0]; .[$v] += 1) | to_entries;

def house:
  (clusters | map(select(.value > 0))) as $cnt
  | if ($cnt | length == 2) and ($cnt[0].value == 2 or $cnt[0].value == 3)
    then add
    else 0
    end
;

def quad:
  (clusters | map(select(.value >= 4))) as $cnt
  | if ($cnt | length == 1)
    then $cnt[0].key * 4
    else 0
    end
;

def seq(p): if sort == p then 30 else 0 end;

def yaht: if (unique | length) == 1 then 50 else 0 end;

.category as $ct
| .dice
| if   $ct == "ones"            then tally(1)
  elif $ct == "twos"            then tally(2)
  elif $ct == "threes"          then tally(3)
  elif $ct == "fours"           then tally(4)
  elif $ct == "fives"           then tally(5)
  elif $ct == "sixes"           then tally(6)
  elif $ct == "full house"      then house
  elif $ct == "four of a kind"  then quad
  elif $ct == "little straight" then seq([1,2,3,4,5])
  elif $ct == "big straight"    then seq([2,3,4,5,6])
  elif $ct == "yacht"           then yaht
  elif $ct == "choice"          then add
  else 0
  end
