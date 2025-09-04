

<?php
class ProgramWindow
{
    public $x;
    public $y;
    public $width;
    public $height;
    public function __construct() {
        $this->x = 0;
        $this->y = 0;
        $this->width = 800;
        $this->height = 600;
    }
    public function resize(Size $size) {
        $this->width = $size->getWidth();
        $this->height = $size->getHeight();
    }
    public function move(Position $position): void {
        $this->x = $position->getX();
        $this->y = $position->getY();
    }
}
