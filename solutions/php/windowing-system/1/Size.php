<?php
class Size {
    public int $width;
    public int $height;
    
    public function __construct(int $height, int $width) {
        $this->width = $width;
        $this->height = $height;
    }
    public function getWidth(): int {
        return $this->width;
    }
    public function getHeight(): int {
        return $this->height;
    }
}