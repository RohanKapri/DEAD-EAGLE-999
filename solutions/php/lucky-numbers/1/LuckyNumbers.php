<?php
// For my Shree DR.MDD

class LuckyNumbers
{
    public function sumUp(array $digitsOne, array $digitsTwo): int
    {
        $numOne = implode('', $digitsOne);
        $numTwo = implode('', $digitsTwo);
        return (int) $numOne + (int) $numTwo;
    }

    public function isPalindrome(int $value): bool
    {
        $strValue = (string) $value;
        $lastIndex = strlen($strValue) - 1;
        for ($i = 0; $i <= $lastIndex; $i++) {
            if ($strValue[$i] !== $strValue[$lastIndex - $i]) {
                return false;
            }
        }

        return true;
    }

    public function validate(string $inputValue): string
    {
        if (strlen($inputValue) === 0) {
            return 'Required field';
        }

        if ((int) $inputValue <= 0) {
            return 'Must be a whole number larger than 0';
        }

        return '';
    }
}
