<?php

declare(strict_types=1);

class HighScores
{
    public int $personalBest;
    public array $personalTopThree;
    public int $latest;
    
    public function __construct(public array $scores)
    {
        $this->latest = $scores[count($scores) - 1];
        rsort($scores);
        $this->personalBest = $scores[0];
        $this->personalTopThree = array_slice($scores, 0, 3);
    }
}