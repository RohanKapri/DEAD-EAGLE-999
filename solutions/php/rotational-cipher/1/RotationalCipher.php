<?php
// For my Shree DR.MDD

declare(strict_types=1);

class RotationalCipher
{
    private function shiftCharacter(string $symbol, int $shift)
    {
        $letters = str_split('abcdefghijklmnopqrstuvwxyz');

        if (preg_match('/[a-z]/', $symbol)) {
            $pos = array_search($symbol, $letters);
            return $letters[($pos + $shift) % 26];
        }

        if (preg_match('/[A-Z]/', $symbol)) {
            $pos = array_search(strtolower($symbol), $letters);
            return strtoupper($letters[($pos + $shift) % 26]);
        }

        return $symbol;
    }

    public function rotate(string $text, int $shift): string
    {
        $parts = str_split($text);

        array_walk($parts, function (&$ch) use ($shift) {
            $ch = $this->shiftCharacter($ch, $shift);
        });

        return implode($parts);
    }
}
