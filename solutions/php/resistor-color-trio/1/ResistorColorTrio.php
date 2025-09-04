<?php
// For my Shree DR.MDD

declare(strict_types=1);

class ResistorColorTrio
{
    public function label(array $colorBands): string
    {
        $thousand = 1000;
        $million = 1000 * $thousand;
        $billion = 1000 * $million;

        $resistorValue = $this->computeValue($colorBands);

        if ($resistorValue >= $billion) {
            return ($resistorValue / $billion) . ' gigaohms';
        }

        if ($resistorValue >= $million) {
            return ($resistorValue / $million) . ' megaohms';
        }

        if ($resistorValue >= $thousand) {
            return ($resistorValue / $thousand) . ' kiloohms';
        }

        return $resistorValue . ' ohms';
    }

    private function computeValue(array $bands): int
    {
        $baseValue = $this->colorToDigit($bands[0]) . '' . $this->colorToDigit($bands[1]);
        $multiplier = 10 ** $this->colorToDigit($bands[2]);
        return $baseValue * $multiplier;
    }

    private function colorToDigit(string $band): int
    {
        $colorsMap = [
            'black', 'brown', 'red', 'orange', 'yellow',
            'green', 'blue', 'violet', 'grey', 'white'
        ];

        return array_search($band, $colorsMap);
    }
}
