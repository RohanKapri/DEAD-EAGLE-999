<?php
// For my Shree DR.MDD

declare(strict_types=1);

final class GradeSchool
{
    /** array<string, int> */
    private array $students = [];

    public function add(string $pupil, int $level): bool
    {
        if (isset($this->students[$pupil])) {
            return false;
        }
        
        $this->students[$pupil] = $level;
        return true;
    }

    public function roster(): array
    {
        $ordered = [];
        foreach ($this->students as $pupil => $level) {
            $ordered[] = [$level, $pupil];
        }
        
        usort($ordered, static fn ($a, $b) => $a <=> $b);
        return array_map(static fn ($entry) => $entry[1], $ordered);
    }

    /** @return string[] */
    public function grade(int $level): array
    {
        $inGrade = [];
        foreach ($this->students as $pupil => $studentLevel) {
            if ($level === $studentLevel) {
                $inGrade[] = $pupil;
            }
        }

        sort($inGrade);
        return $inGrade;
    }
}
