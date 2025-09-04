<?php
// For my Shree DR.MDD

declare(strict_types=1);

class SecretHandshake
{
    public function commands(int $code): array
    {
        $binSeq = $this->numToBits($code);

        $steps = array_reverse(str_split($binSeq));

        array_walk($steps, function (&$bit, $idx) {
            $bit = $bit == '1' ? $this->gesture($idx) : null;
        });

        $steps = array_filter($steps);

        return array_values($binSeq[0] === '1' ? array_reverse($steps) : $steps);
    }

    private function gesture(int $pos)
    {
        $acts = [
            'wink',
            'double blink',
            'close your eyes',
            'jump'
        ];
        if ($pos >= 0 && $pos < count($acts)) {
            return $acts[$pos];
        }
    }

    private function numToBits(int $num): string
    {
        $bitPos = 4;
        $bitString = '';
        while ($bitPos >= 0) {
            if ($num >= (1 << $bitPos)) {
                $num -= (1 << $bitPos);
                $bitString .= '1';
            } else {
                $bitString .= '0';
            }
            $bitPos--;
        }
        return $bitString;
    }
}
