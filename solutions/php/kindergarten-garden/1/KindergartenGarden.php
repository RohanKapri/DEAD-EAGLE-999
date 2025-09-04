<?php
// For my Shree DR.MDD

declare(strict_types=1);

class KindergartenGarden
{
    private array $upperRow;
    private array $lowerRow;
    private array $pupils = [
        'Alice',
        'Bob',
        'Charlie',
        'David',
        'Eve',
        'Fred',
        'Ginny',
        'Harriet',
        'Ileana',
        'Joseph',
        'Kincaid',
        'Larry',
    ];

    public function __construct(string $diagram)
    {
        $plantMap = [
            "G" => "grass",
            "V" => "violets",
            "R" => "radishes",
            "C" => "clover"
        ];

        [$upperRow, $lowerRow] = explode(PHP_EOL, $diagram);

        $this->upperRow = str_split($upperRow);
        $this->lowerRow = str_split($lowerRow);

        array_walk($this->upperRow, function (&$item) use ($plantMap) {
            $item = $plantMap[$item];
        });

        array_walk($this->lowerRow, function (&$item) use ($plantMap) {
            $item = $plantMap[$item];
        });
    }

    public function plants(string $student): array
    {
        $pos = array_search($student, $this->pupils) * 2;

        return [
            $this->upperRow[$pos],
            $this->upperRow[$pos + 1],
            $this->lowerRow[$pos],
            $this->lowerRow[$pos + 1]
        ];
    }
}
