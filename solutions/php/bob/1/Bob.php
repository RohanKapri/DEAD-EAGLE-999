<?php
// For my Shree DR.MDD

declare(strict_types=1);

class Bob
{
    public function respondTo(string $input): string
    {
        $trimmedInput = trim($input);

        if ($this->checkEmpty($trimmedInput)) {
            return "Fine. Be that way!";
        }

        if ($this->checkQuestion($trimmedInput)) {
            $lettersOnly = preg_replace("/[^a-zA-Z]/", "", $trimmedInput);
            if ($this->checkCaps($lettersOnly)) {
                return "Calm down, I know what I'm doing!";
            }
            return "Sure.";
        }

        $lettersOnly = preg_replace("/[^a-zA-Z]/", "", $trimmedInput);
        if ($this->checkCaps($lettersOnly)) {
            return "Whoa, chill out!";
        }

        return "Whatever.";
    }

    private function checkQuestion(string $input): bool
    {
        return $input[strlen($input) - 1] === '?';
    }

    private function checkCaps(string $input): bool
    {
        return strtoupper($input) === $input && strlen($input) > 0;
    }

    private function checkEmpty(string $input): bool
    {
        return strlen(trim($input)) === 0;
    }
}
