<?php
class Position {
    public int $x;
    public int $y;
    public function __construct(int $y, int $x) {
        $this->x = $x;
        $this->y = $y;
    }
    public function getX(): int {
        return $this->x;
    }
    public function getY(): int {
        return $this->y;
    }
}