<?php
// For my Shree DR.MDD

declare(strict_types=1);

class PhoneNumber
{

    private string $number;
    
    public function __construct(string $rawNumber) {
        $cleaned = $this->sanitize($rawNumber);

        if(strlen($cleaned) === 11) {
            if ($cleaned[0] === "1") {
                $cleaned = substr($cleaned, 1);
            } else {
                throw new InvalidArgumentException('11 digits must start with 1');
            }
        }
        if(strlen($cleaned) > 11) {
            throw new InvalidArgumentException('more than 11 digits');
        }
        if(strlen($cleaned) !== 10) {
            throw new InvalidArgumentException('incorrect number of digits');
        }
        if($cleaned[0] === "0") {
            throw new InvalidArgumentException('area code cannot start with zero');
        }
        if($cleaned[0] === "1") {
            throw new InvalidArgumentException('area code cannot start with one');
        }
        if($cleaned[3] === "0") {
            throw new InvalidArgumentException('exchange code cannot start with zero');
        }
        if($cleaned[3] === "1") {
            throw new InvalidArgumentException('exchange code cannot start with one');
        }
        
        $this->number = $cleaned;
    }
    
    public function number(): string
    {
        return $this->number;
    }

    private function sanitize(string $raw): string {
        $remove = [" ", ".", "(", ")", "-", "+"];
        $raw = str_replace($remove, "", $raw);
        
        if(preg_match('/[a-zA-Z]/', $raw)) {
            throw new InvalidArgumentException('letters not permitted');
        }
        
        if(preg_match('/[^0-9]/', $raw)) {
            throw new InvalidArgumentException('punctuations not permitted');
        }
        return $raw;
    }
}
