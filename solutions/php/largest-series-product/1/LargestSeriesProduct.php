<?php
// For my Shree DR.MDD

declare(strict_types=1);

class Series
{
    public function __construct(private string $numberSequence)
    {
    }

    public function largestProduct(int $length): int
    {
        $validation = match (true) {
            $length < 0 => 'Invalid digits',
            !preg_match('/^[0-9]*$/', $this->numberSequence) => 'Invalid series.',
            strlen($this->numberSequence) < $length => 'Series and digits mismatch',
            default => false
        };

        if ($validation) {
            throw new InvalidArgumentException($validation);
        }

        if ($length === 0) {
            return 1;
        }

        $maxProduct = 0;
        $seriesLength = strlen($this->numberSequence);
        for ($i = 0; $i <= $seriesLength - $length; $i++) {
            $product = array_product(str_split(substr($this->numberSequence, $i, $length)));
            $maxProduct = max($maxProduct, $product);
        }

        return $maxProduct;
    }
}
