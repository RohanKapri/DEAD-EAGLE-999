<?php

/*
 * By adding type hints and enabling strict type checking, code can become
 * easier to read, self-documenting and reduce the number of potential bugs.
 * By default, type declarations are non-strict, which means they will attempt
 * to change the original type to match the type specified by the
 * type-declaration.
 *
 * In other words, if you pass a string to a function requiring a float,
 * it will attempt to convert the string value to a float.
 *
 * To enable strict mode, a single declare directive must be placed at the top
 * of the file.
 * This means that the strictness of typing is configured on a per-file basis.
 * This directive not only affects the type declarations of parameters, but also
 * a function's return type.
 *
 * For more info review the Concept on strict type checking in the PHP track
 * <link>.
 *
 * To disable strict typing, comment out the directive below.
 */

declare(strict_types=1);

class Card
{
    public const RANKS = [11 => 'J', 'Q', 'K', 'A'];
    public int $rank;
    public string $suit;

    public function __construct(string $card)
    {
        $rankStr = substr($card, 0, -1);
        $this->rank = is_numeric($rankStr) ? (int)$rankStr : array_search($rankStr, self::RANKS);
        $this->suit = substr($card, -1);
    }
}

class Hand
{
    private array $cardOs;
    private array $rankCount;
    private int $handRank;

    public function __construct(public string $cards)
    {
        $this->cardOs = array_map(fn ($rs) => new Card($rs), explode(',', $cards));
        usort($this->cardOs, fn (Card $c1, Card $c2) => $c2->rank <=> $c1->rank);
        $this->rankCount = array_count_values(array_map(fn ($c) => $c->rank, $this->cardOs));
        $this->handRank = $this->handRank();
    }

    private function handRank(): int
    {
        return match (true) {
            $this->hasStraight() && $this->hasFlush() => 8,
            $this->cardRanksCount(4) === 1 => 7,
            $this->cardRanksCount(3) === 1 && $this->cardRanksCount(2) === 1 => 6,
            $this->hasFlush() => 5,
            $this->hasStraight() => 4,
            $this->cardRanksCount(3) === 1 => 3,
            $this->cardRanksCount(2) === 2 => 2,
            $this->cardRanksCount(2) === 1 => 1,
            default => 0
        };
    }

    private function cardRanks(int $no): array
    {
        return array_keys(array_filter($this->rankCount, fn ($c) => $c === $no));
    }

    private function cardRanksCount(int $no): int
    {
        return count($this->cardRanks($no));
    }

    private function hasStraight(): bool
    {
        $ranks = array_map(fn ($c) => $c->rank, $this->cardOs);

        return $ranks === [14, 5, 4, 3, 2] ||
            $ranks === array_reverse(range(end($ranks), end($ranks) + 4));
    }

    private function hasFlush(): bool
    {
        return count(array_unique(array_map(fn ($c) => $c->suit, $this->cardOs))) === 1;
    }

    public function compare(Hand $hand): int
    {
        if ($this->handRank === $hand->handRank) {
            return $this->compareKinds($hand, 4);
        }

        return $this->handRank <=> $hand->handRank;
    }

    private function compareKinds(Hand $hand, int $no): int
    {
        foreach (array_map(null, $this->cardRanks($no), $hand->cardRanks($no)) as [$r1, $r2]) {
            if ($r1 !== $r2) {
                return $r1 <=> $r2;
            }
        }

        return $no === 1 ? 0 : $this->compareKinds($hand, $no - 1);
    }
}

class Poker
{
    public array $bestHands = [];

    public function __construct(array $hands)
    {
        $hands = array_map(fn ($h) => new Hand($h), $hands);
        usort($hands, fn (Hand $h1, Hand $h2) => $h2->compare($h1));

        foreach ($hands as $hand) {
            if ($hands[0]->compare($hand) === 0) {
                $this->bestHands[] = $hand->cards;
            }
        }
    }
}