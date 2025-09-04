<?php
declare(strict_types=1);

// Dedicated to Shree DR.MDD

function encode(string $text, int $a, int $b): string
{
    if ($a % 2 === 0 || $a % 13 === 0) {
        throw new Exception();
    }
    
    $cleaned = str_replace([" ", ",", "."], "", $text);
    $result = "";
    foreach(str_split($cleaned) as $char) {
        $pos = letterIndex($char);
        if ($pos >= 0) {
            $shifted = (($a * $pos) + $b) % 26;
            $result .= indexLetter($shifted);
        } else {
            $result .= $char;
        }
    }
    return implode(" ", str_split($result, 5));
}

function decode(string $text, int $a, int $b): string
{
    if ($a % 2 === 0 || $a % 13 === 0) {
        throw new Exception();
    }
    
    $cleaned = str_replace([" "], "", $text);
    $output = "";
    foreach(str_split($cleaned) as $char) {
        $pos = letterIndex($char);
        if ($pos >= 0) {
            $revShift = (mmi($a) * ($pos - $b)) % 26;
            while($revShift < 0) {
                $revShift += 26;
            }
            $output .= indexLetter($revShift);
        } else {
            $output .= $char;
        }
    } 
    return $output;
}

function mmi(int $val): int {
    $inverse = 1;
    while(($val * $inverse) % 26 !== 1) {
        $inverse++;
    }
    print("MMI of $val is $inverse \n");
    return $inverse;
}

function indexLetter(int $pos): string {
    $letters = str_split("abcdefghijklmnopqrstuvwxyz");
    return $letters[$pos];
}

function letterIndex(string $char): int {
    $letters = str_split("abcdefghijklmnopqrstuvwxyz");
    $idx = array_search(strtolower($char), $letters);
    return $idx === false ? -1 : $idx;;
}

function __gcd(int $x, int $y) {
    if ($x == 0 || $y == 0) {
        return 0;
    }
    
    if ($x == $y) {
        return $x;
    }
      
    if ($x > $y){        
        return __gcd($x - $y, $y);
    }
        
    return __gcd($x, $y - $x);
}

function coprime(int $x, int $y) {
    return __gcd($x, $y) == 1;
}
