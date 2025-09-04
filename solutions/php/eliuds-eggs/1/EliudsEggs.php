<?php
declare(strict_types=1);
class EliudsEggs
{
    public function eggCount(int $displayValue): int
    {
        $numberOfEggs = 0;
        $highestPowerOfTwo = ceil(log($displayValue) / log(2));
        $remainder = $displayValue;
    
        while ($remainder > 0) {
            $binaryFactor = pow(2, $highestPowerOfTwo);
            if ($remainder >= $binaryFactor) {
                $numberOfEggs += 1;
                $remainder -= $binaryFactor;
            }
            $highestPowerOfTwo -= 1;
        }
    
        return $numberOfEggs;
    }
}