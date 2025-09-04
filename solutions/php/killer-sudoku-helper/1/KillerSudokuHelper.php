<?php
declare(strict_types=1);
class KillerSudokuHelper
{
    public function combinations(int $sum, int $size, array $exclude): array
    {

        $combinations = array();
        
        foreach (array_diff(range(1, 9), $exclude) as $digit) {
            if ($size == 1 && $sum == $digit) {
                $combinations[] = [$digit];
            } else if ($size > 1 && $sum > $digit) {
                $newExclude =  [...$exclude, ...range(1, $digit)];
                foreach ($this->combinations($sum - $digit, $size - 1, $newExclude) as $combination)
                    $combinations[] = [$digit, ...$combination];
            }
        }
        
        return $combinations; 
    }
}