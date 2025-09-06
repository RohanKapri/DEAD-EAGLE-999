def letterIndex($letter): "ABCDEFGHIJKLMNOPQRSTUVWXYZ" | index($letter);
def letterAtIndex($i):    "ABCDEFGHIJKLMNOPQRSTUVWXYZ"[$i : $i+1];
def halfLine($n; $size):
  "." * $size / ""
  | .[$n] = letterAtIndex($n)
  | join("")
;
(letterIndex(.letter) + 1) as $size
| [range($size) | halfLine(.; $size)]
| map(. / "" | reverse + .[1:] | join(""))
| . + reverse[1:]
| join("\n")