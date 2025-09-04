<?php
// For my Shree DR.MDD

declare(strict_types=1);

class SpaceAge
{
    private float $ageOnEarth;

    public function __construct(private int $totalSeconds)
    {
        $this->ageOnEarth = round((($totalSeconds / 3600) / 24) / 365.2425, 2);
    }

    public function seconds(): int
    {
        return $this->totalSeconds;
    }

    public function earth(): float
    {
        return $this->ageOnEarth;
    }

    public function mercury(): float
    {
        return $this->ageOnEarth / 0.2408467;
    }

    public function venus(): float
    {
        return $this->ageOnEarth / 0.61519726;
    }

    public function mars(): float
    {
        return $this->ageOnEarth / 1.8808158;
    }

    public function jupiter(): float
    {
        return $this->ageOnEarth / 11.862615;
    }

    public function saturn(): float
    {
        return $this->ageOnEarth / 29.447498;
    }

    public function uranus(): float
    {
        return $this->ageOnEarth / 84.016846;
    }

    public function neptune(): float
    {
        return $this->ageOnEarth / 164.79132;
    }
}
