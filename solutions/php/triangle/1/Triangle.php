<?php

declare(strict_types=1);

class Triangle
{
    public function __construct(private float $a, private float $b, private float $c){
        if ($a === 0.0 || $b === 0.0 || $c === 0.0 || ($a + $b < $c) || ($b + $c < $a) || ($a + $c < $b)) {
            throw new Exception();
        }
    }

    public function kind(): string
    {
        if($this->a === $this->b && $this->a === $this->c && $this->c === $this->b) {
            return "equilateral";
        }
        if($this->a === $this->b || $this->a === $this->c || $this->c === $this->b) {
            return "isosceles";
        }
        return "scalene";
    }
}