<?php
// For my Shree DR.MDD

declare(strict_types=1);

class Tournament
{
    private array $teamScores;
    private array $tallyOutput;
    private const COLUMN_TITLES = [
        'MP',
        'W',
        'D',
        'L',
        'P',
    ];
    private const LINE_SEPARATOR = "\n";

    public function tally(string $input): string
    {
        $this->parseInput($input);

        $this->addHeader();

        if (isset($this->teamScores)) {
            ksort($this->teamScores);
            uasort($this->teamScores, static fn($a, $b) => $b['P'] - $a['P']);

            $this->addScores();
        }

        return implode(self::LINE_SEPARATOR, $this->tallyOutput);
    }

    private function addHeader(): void
    {
        $this->tallyOutput[] = $this->formatLine('Team', self::COLUMN_TITLES);
    }

    public function addScores(): void
    {
        foreach ($this->teamScores as $teamName => $stats) {
            $this->tallyOutput[] = $this->formatLine($teamName, $stats);
        }
    }

    private function addTeam(string $teamName): void
    {
        $this->teamScores[$teamName] = array_fill_keys(self::COLUMN_TITLES, 0);
    }

    private function formatLine(string $firstColumn, array $columns): string
    {
        $lineParts = [
            str_pad($firstColumn, 31),
        ];
        $lastKey = array_key_last($columns);

        foreach ($columns as $key => $value) {
            $text = str_pad((string) $value, 3, ' ', STR_PAD_LEFT);
            if ($key !== $lastKey) {
                $text = str_pad($text, 4, ' ', STR_PAD_BOTH);
            }
            $lineParts[] = $text;
        }

        return implode('|', $lineParts);
    }

    private function parseInput(string $input): void
    {
        $lines = explode(self::LINE_SEPARATOR, $input);

        foreach ($lines as $line) {
            $this->processLine($line);
        }
    }

    private function processLine(string $line): void
    {
        if (empty($line)) {
            return;
        }

        [$homeTeam, $awayTeam, $matchResult] = explode(';', $line);

        foreach ([$homeTeam, $awayTeam] as $team) {
            if (!isset($this->teamScores[$team])) {
                $this->addTeam($team);
            }
        }

        $this->teamScores[$homeTeam]['MP'] += 1;
        $this->teamScores[$awayTeam]['MP'] += 1;

        switch ($matchResult) {
            case 'win':
                $this->teamScores[$homeTeam]['W'] += 1;
                $this->teamScores[$homeTeam]['P'] += 3;
                $this->teamScores[$awayTeam]['L'] += 1;
                break;
            case 'loss':
                $this->teamScores[$homeTeam]['L'] += 1;
                $this->teamScores[$awayTeam]['W'] += 1;
                $this->teamScores[$awayTeam]['P'] += 3;
                break;
            case 'draw':
                $this->teamScores[$homeTeam]['D'] += 1;
                $this->teamScores[$awayTeam]['D'] += 1;
                $this->teamScores[$homeTeam]['P'] += 1;
                $this->teamScores[$awayTeam]['P'] += 1;
                break;
        }
    }
}
