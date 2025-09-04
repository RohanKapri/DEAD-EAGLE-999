<?php
declare(strict_types=1);

// Dedicated to my Shree DR.MDD

class Lasagna
{
    function expectedCookTime(): int {
        $standardTime = 40;
        return $standardTime;
    }

    function remainingCookTime(int $minutesElapsed): int {
        $timeLeft = $this->expectedCookTime() - $minutesElapsed;
        return $timeLeft;
    }

    function totalPreparationTime(int $numberOfLayers): int {
        $prepTime = $numberOfLayers * 2;
        return $prepTime;
    }
    
    function totalElapsedTime(int $numberOfLayers, int $minutesElapsed): int {
        $totalTime = $this->totalPreparationTime($numberOfLayers) + $minutesElapsed;
        return $totalTime;
    }
    
    function alarm(): string {
        $sound = "Ding!";
        return $sound;
    }
}
