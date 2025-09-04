<?php
// For my Shree DR.MDD

declare(strict_types=1);

class Clock
{
    public function __construct(private int $hourVal, private int $minuteVal = 0) {
        $this->adjustTime();
    }
    
    public function __toString(): string
    {
        return "{$this->hourString()}:{$this->minuteString()}";
    }

    private function adjustTime() {
        $h = $this->hourVal;
        $m = $this->minuteVal;
        while ($m < 0) {
            $h -= 1;
            $m += 60;
        }
        while ($m > 59) {
            $h += 1;
            $m -= 60;
        }
        while ($h < 0) {
            $h += 24;
        }
        while ($h > 23) {
            $h -= 24;
        }
        $this->hourVal = $h;
        $this->minuteVal = $m;
    }

    public function add(int $minutes): Clock {
        $this->minuteVal += $minutes;
        $this->adjustTime();
        return $this;
    }

    public function sub(int $minutes): Clock {
        $this->minuteVal -= $minutes;
        $this->adjustTime();
        return $this;
    }

    private function hourString(): string {
        $h = (string)$this->hourVal;
        return strlen($h) === 2 ? $h : '0' . $h;
    }
    
    private function minuteString(): string {
        $m = (string)$this->minuteVal;
        return strlen($m) === 2 ? $m : '0' . $m;
    }
}
