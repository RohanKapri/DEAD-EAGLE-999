<?php
declare(strict_types=1);
class ResistorColorDuo
{
    public function getColorsValue(array $colors): int
    {
        return (int)($this::getColorValue($colors[0]) . $this::getColorValue($colors[1]));   
    }
    private static function getColorValue(string $color): string {
        $colors = [
            'black' => "0",
            'brown' => '1',
            'red' => '2',
            'orange' => '3',
            'yellow' => '4',
            'green' => '5',
            'blue' => '6',
            'violet' => '7',
            'grey' => '8',
            'white' => '9'
        ];
        return $colors[$color]; 
    }
}