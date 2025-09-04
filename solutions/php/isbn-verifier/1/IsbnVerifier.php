<?php
declare(strict_types=1);
class IsbnVerifier
{
    public function isValid(string $isbn): bool
    {
        $sanitized = str_replace('-', '', $isbn);
        
        $digits = str_split(str_replace('-', '', $isbn));
        
        foreach ($digits as $index => &$digit) {
            if ($digit == 'X' && $index == 9)
                $digit = 10;
            else if (!is_numeric($digit))
                return false;
            else
                $digit = (int) $digit;
        }
        return strlen($sanitized) == 10 && 
            ($digits[0] * 10 + $digits[1] * 9 + $digits[2] * 8 + $digits[3] * 7 +
             $digits[4] * 6 + $digits[5] * 5 + $digits[6] * 4 + $digits[7] * 3 +
             $digits[8] * 2 + $digits[9]) % 11 == 0;
    }
}