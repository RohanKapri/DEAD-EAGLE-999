<?php
declare(strict_types=1);
function pascalsTriangleRows($rowCount)
{
    if($rowCount === null || $rowCount < 0) {
        return -1;
    }
    if($rowCount === 0) {
        return [];
    }
    $triangle = [[1]];
    for($i = 1; $i < $rowCount; $i++) {
        $triangle[$i] = [];
        array_unshift($triangle[$i - 1], 0);
        $triangle[$i - 1][] = 0;
        for($j = 0; $j < count($triangle[$i - 1]) - 1; $j++) {
            $triangle[$i][] = $triangle[$i - 1][$j] + $triangle[$i - 1][$j + 1];            
        }
        array_splice($triangle[$i - 1], 0, 1);
        array_splice($triangle[$i - 1], count($triangle[$i -1]) - 1, 1);
        }
    print_r($triangle);
    return $triangle;
}