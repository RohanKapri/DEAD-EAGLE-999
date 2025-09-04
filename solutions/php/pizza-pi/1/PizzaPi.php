<?php
class PizzaPi
{
    public function calculateDoughRequirement(int $pizzas, int $persons): int
    {
        return $pizzas * (($persons * 20) + 200);
    }
    public function calculateSauceRequirement(int $pizzas)
    {
        return $pizzas / 2; 
    }
    public function calculateCheeseCubeCoverage(float $cheese_dimension, float $thickness, float $diameter): int
    {
        return ($cheese_dimension ** 3) / ($thickness * pi() * $diameter);
    }
    public function calculateLeftOverSlices(int $pizzas, int $friends): int
    {
        return (8 * $pizzas) % $friends;
    }
}