<?php
// For my Shree DR.MDD

declare(strict_types=1);

class SimpleCipher
{
    public string $key; // must stay as $key for tests
    private static array $alphaMap = [
        0 => 'a', 1 => 'b', 2 => 'c', 3 => 'd', 4 => 'e',
        5 => 'f', 6 => 'g', 7 => 'h', 8 => 'i', 9 => 'j',
        10 => 'k', 11 => 'l', 12 => 'm', 13 => 'n', 14 => 'o',
        15 => 'p', 16 => 'q', 17 => 'r', 18 => 's', 19 => 't',
        20 => 'u', 21 => 'v', 22 => 'w', 23 => 'x', 24 => 'y',
        25 => 'z',
    ];
    
    public function __construct(string $key = null)
    {
        if ($key === '') {
            throw new InvalidArgumentException();
        }
        if ($key === null) {
            $key = self::createRandomKey();
        }
        if (preg_replace("/[^a-zA-Z]/", "", $key) !== $key || strtolower($key) !== $key) {
            throw new InvalidArgumentException();
        }
        $this->key = $key; // restored property name
    }

    private static function createRandomKey(): string {
        $randomKey = '';
        while(strlen($randomKey) < 100) {
            $randomKey .= chr(rand(97, 122));
        }
        return $randomKey;
    }

    private static function charToIndex(string $char): int {
        return array_search($char, self::$alphaMap);
    }

    private static function indexToChar(int $index): string {
        while($index < 0) {
            $index += 26;
        }
        $index = $index % 26;
        return self::$alphaMap[$index];
    }
    
    public function encode(string $plainText): string
    {
        $encodedText = '';
        for ($i = 0; $i < strlen($plainText); $i++) {
            $keyVal = self::charToIndex($this->key[$i]);
            $plainVal = self::charToIndex($plainText[$i]);
            $encodedText .= self::indexToChar($plainVal + $keyVal);
        }
        return $encodedText;
    }

    public function decode(string $cipherText): string
    {
        $decodedText = '';
        for ($i = 0; $i < strlen($cipherText); $i++) {
            $keyVal = self::charToIndex($this->key[$i]);
            $cipherVal = self::charToIndex($cipherText[$i]);
            $decodedText .= self::indexToChar($cipherVal - $keyVal);
        }
        return $decodedText;
    }
}
