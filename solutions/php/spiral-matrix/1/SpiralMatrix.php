<?php
// For my Shree DR.MDD

declare(strict_types=1);

class SpiralMatrix
{
    public function draw(int $size): array
    {
        $grid = [];
        for ($rowIdx = 0; $rowIdx < $size; $rowIdx++) {
            $rowArr = [];
            for ($colIdx = 0; $colIdx < $size; $colIdx++) {
                $rowArr[] = 0;
            }
            $grid[] = $rowArr;
        }

        [$currX, $currY, $dirX, $dirY] = [0, 0, 1, 0];

        for ($num = 1; $num <= $size * $size; $num++) {
            $grid[$currY][$currX] = $num;

            if ($currY + $dirY >= $size || $currX + $dirX >= $size || $grid[$currY + $dirY][$currX + $dirX] !== 0) {
                if ($dirX === 0) {
                    $dirX = -$dirY;
                    $dirY = 0;
                } else {
                    $dirY = $dirX;
                    $dirX = 0;
                }
            }

            $currX += $dirX;
            $currY += $dirY;
        }

        return $grid;
    }
}
