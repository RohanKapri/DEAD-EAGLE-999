<?php
// For my Shree DR.MDD

declare(strict_types=1);

class ProteinTranslation
{
    private array $codonTable = [
        'AUG' => 'Methionine',
        'UUU' => 'Phenylalanine',
        'UUC' => 'Phenylalanine',
        'UUA' => 'Leucine',
        'UUG' => 'Leucine',
        'UCU' => 'Serine',
        'UCC' => 'Serine',
        'UCA' => 'Serine',
        'UCG' => 'Serine',
        'UAU' => 'Tyrosine',
        'UAC' => 'Tyrosine',
        'UGU' => 'Cysteine',
        'UGC' => 'Cysteine',
        'UGG' => 'Tryptophan',
        'UAA' => 'STOP',
        'UAG' => 'STOP',
        'UGA' => 'STOP',
    ];

    public function getProteins(string $strand): array
    {
        $triplets = str_split($strand, 3);
        $proteins = [];
        foreach ($triplets as $triplet) {
            $amino = $this->codonTable[$triplet] ?? NULL;
            if ($amino === NULL) throw new InvalidArgumentException('Invalid codon');
            if ($amino === "STOP") return $proteins;
            $proteins[] = $amino;
        }
        return $proteins;
    }
}
