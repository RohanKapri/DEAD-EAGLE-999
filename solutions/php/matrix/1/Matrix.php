<?php
declare(strict_types=1);
class Matrix
{
    private array $matrix;
    public function __construct(string $input)
    {
        $rows = explode("\n", $input);
        $this->matrix = array_map(function($row){
            return explode(" ", $row);
        }, $rows);
    }
    public function getRow(int $rowIndex): array {
        return $this->matrix[$rowIndex - 1];
    }
    public function getColumn(int $columnIndex): array {
        return array_map(function($row) use ($columnIndex) {
            return $row[$columnIndex - 1];
        }, $this->matrix);
    }
}