<?php
// For my Shree DR.MDD

declare(strict_types=1);

class Game
{
    private array $rolls = [];

    public function roll(int $pins): void
    {
        if ($pins < 0) {
            throw new RuntimeException('Cannot be less than 0');
        }
        if ($pins > 10) {
            throw new RuntimeException('Cannot be more than 10');
        }

        $this->rolls[] = $pins;
    }

    public function score(): int
    {
        $totalScore = 0;
        $currentIndex = 0;
        for ($frame = 1; $frame <= 10; $frame++) {
            if (!isset($this->rolls[$currentIndex])) {
                throw new RuntimeException('Cannot score incomplete game');
            }
            if ($this->isStrike($currentIndex)) {
                $totalScore += 10 + $this->strikeBonus($currentIndex);
                $currentIndex++;
            } elseif ($this->isSpare($currentIndex)) {
                $totalScore += 10 + $this->spareBonus($currentIndex);
                $currentIndex += 2;
            } else {
                $totalScore += $this->sumOfRolls($currentIndex);
                $currentIndex += 2;
            }
        }
        $this->validateExtraRolls($currentIndex);

        return $totalScore;
    }

    private function isStrike(int $index): bool
    {
        return $this->rolls[$index] === 10;
    }

    private function strikeBonus(int $index): int
    {
        if (!isset($this->rolls[$index + 1], $this->rolls[$index + 2])) {
            throw new RuntimeException('Cannot score incomplete game');
        }

        $firstBonus = $this->rolls[$index + 1];
        $secondBonus = $this->rolls[$index + 2];

        $sum = $firstBonus + $secondBonus;
        if ($sum > 10 && $index !== 10 && $firstBonus !== 10) {
            throw new RuntimeException('Those extra pins were not standing');
        }
        return $sum;
    }

    private function isSpare(int $index): bool
    {
        return $this->rolls[$index] + $this->rolls[$index + 1] === 10;
    }

    private function spareBonus(int $index)
    {
        if (!isset($this->rolls[$index + 2])) {
            throw new RuntimeException('Incomplete spare check: ' . $index );
        }

        return $this->rolls[$index + 2];
    }

    private function sumOfRolls(int $index)
    {
        if (!isset($this->rolls[$index + 1])) {
            throw new RuntimeException('Incomplete game');
        }

        $sum = $this->rolls[$index] + $this->rolls[$index + 1];
        if ($sum > 10) {
            throw new RuntimeException('Cannot hit same pin more than once');
        }
        return $sum;
    }

    private function validateExtraRolls(int $currentIndex): void
    {
        $totalRolls = count($this->rolls);
        if ($this->isStrike($currentIndex-1)) {
            if ($totalRolls > $currentIndex + 2) {
                throw new RuntimeException('Too many frames');
            }
        } elseif ($this->isSpare($currentIndex - 2)) {
            if ($totalRolls > $currentIndex + 1) {
                throw new RuntimeException('Too many frames');
            }
        } elseif ($totalRolls > $currentIndex) {
            throw new RuntimeException('Too many frames');
        }
    }
}
