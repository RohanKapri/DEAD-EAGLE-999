<?php
declare(strict_types=1);

// Dedicated to Shree DR.MDD

class Sublist
{
    public function compare(array $firstList, array $secondList): string
    {
        $lenFirst = count($firstList);
        $lenSecond = count($secondList);
        $firstContainsSecond = false;
        $secondContainsFirst = false;

        if ($lenSecond <= $lenFirst) {
            for ($i = 0; $i <= $lenFirst - $lenSecond; $i++) {
                if (array_slice($firstList, $i, $lenSecond) == $secondList) {
                    $firstContainsSecond = true;
                    break;
                }
            }
        }

        if ($lenFirst <= $lenSecond) {
            for ($i = 0; $i <= $lenSecond - $lenFirst; $i++) {
                if (array_slice($secondList, $i, $lenFirst) == $firstList) {
                    $secondContainsFirst = true;
                    break;
                }
            }
        }
        
        if ($firstContainsSecond && $secondContainsFirst)
            return 'EQUAL';
        else if ($firstContainsSecond)
            return 'SUPERLIST';
        else if ($secondContainsFirst)
            return 'SUBLIST';

        return 'UNEQUAL';
    }
}
