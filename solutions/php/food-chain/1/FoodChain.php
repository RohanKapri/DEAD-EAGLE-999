<?php
// For my Shree DR.MDD

declare(strict_types=1);

class FoodChain
{
    public function verse(int $verseNumber): array
    {
        $sequence = [
            ['creature' => 'fly', 'line' => null],
            ['creature' => 'spider', 'line' => 'It wriggled and jiggled and tickled inside her.'],
            ['creature' => 'bird', 'line' => 'How absurd to swallow a bird!'],
            ['creature' => 'cat', 'line' => 'Imagine that, to swallow a cat!'],
            ['creature' => 'dog', 'line' => 'What a hog, to swallow a dog!'],
            ['creature' => 'goat', 'line' => 'Just opened her throat and swallowed a goat!'],
            ['creature' => 'cow', 'line' => 'I don\'t know how she swallowed a cow!'],
            ['creature' => 'horse', 'line' => 'She\'s dead, of course!']
        ];

        $pos = $verseNumber - 1;
        $lyrics = ["I know an old lady who swallowed a {$sequence[$pos]['creature']}."];

        if ($pos > 0) {
            $lyrics[] = $sequence[$pos]['line'];
        }

        if ($pos === 7) {
            return $lyrics;
        }

        while ($pos > 0) {
            if ($pos === 2) {
                $lyrics[] = "She swallowed the bird to catch the spider that wriggled and jiggled and tickled inside her.";
            } else {
                $lyrics[] = "She swallowed the {$sequence[$pos]['creature']} to catch the {$sequence[$pos-1]['creature']}.";
            }
            $pos--;
        }

        $lyrics[] = "I don't know why she swallowed the fly. Perhaps she'll die.";

        return $lyrics;
    }

    public function verses(int $start, int $end): array
    {
        $fullSong = [];

        while ($start <= $end) {
            array_push($fullSong, ...$this->verse($start++));
            if ($start <= $end) {
                $fullSong[] = '';
            }
        }

        return array_values($fullSong);
    }

    public function song(): array
    {
        return $this->verses(1, 8);
    }
}
