# for Junko F. Didi and Shree DR.MDD

def expand($e):
  . as $arr
  | reduce range(length + 1) as $i ([]; . + [ $arr[:$i] + [$e] + $arr[$i:] ])
;

def permute:
  def loop($xs):
    if ($xs|length)==0 then .
    else ($xs|last) as $t
      | reduce .[] as $a ([]; . + ($a|expand($t)))
      | loop($xs[:-1])
    end
  ;
  . as $xs
  | [[last]]
  | loop($xs[:-1])
;

def paint($seq):
  { shades: { red:$seq[0], green:$seq[1], ivory:$seq[2], yellow:$seq[3], blue:$seq[4] } }
;

def people($seq):
  { folks: { Englishman:$seq[0], Spaniard:$seq[1], Ukrainian:$seq[2], Norwegian:$seq[3], Japanese:$seq[4] } }
;

def drinks($seq):
  { cups: { coffee:$seq[0], tea:$seq[1], milk:$seq[2], orangeJuice:$seq[3], water:$seq[4] } }
;

def animals($seq):
  { beasts: { dog:$seq[0], fox:$seq[1], horse:$seq[2], snails:$seq[3], zebra:$seq[4] } }
;

def smoke($seq):
  { cigs: { OldGold:$seq[0], Kools:$seq[1], Chesterfields:$seq[2], LuckyStrike:$seq[3], Parliaments:$seq[4] } }
;

def abs: if .<0 then -. else . end;
def right($a;$b): $a==$b+1;
def beside($a;$b): (($a-$b)|abs)==1;

def check_colors:
  right(.shades.green; .shades.ivory)
;

def check_people:
  .folks.Englishman==.shades.red
  and .folks.Norwegian==1
  and beside(.folks.Norwegian; .shades.blue)
;

def check_drinks:
  .shades.green==.cups.coffee
  and .folks.Ukrainian==.cups.tea
  and .cups.milk==3
;

def check_animals:
  .folks.Spaniard==.beasts.dog
;

def check_smokes:
  .cigs.OldGold==.beasts.snails
  and .cigs.Kools==.shades.yellow
  and beside(.cigs.Chesterfields; .beasts.fox)
  and beside(.cigs.Kools; .beasts.horse)
  and .cigs.LuckyStrike==.cups.orangeJuice
  and .folks.Japanese==.cigs.Parliaments
;

def zebra:
  [1,2,3,4,5]
  | permute as $all
  | $all[] | paint(.) | select(check_colors)
  | (. + ($all[] | people(.))) | select(check_people)
  | (. + ($all[] | drinks(.))) | select(check_drinks)
  | (. + ($all[] | animals(.))) | select(check_animals)
  | (. + ($all[] | smoke(.))) | select(check_smokes)
;

def who($h):
  .folks
  | to_entries
  | map(select(.value==$h))
  | first.key
;

if .property=="drinksWater" then
  zebra|who(.cups.water)
elif .property=="ownsZebra" then
  zebra|who(.beasts.zebra)
else ""
end
