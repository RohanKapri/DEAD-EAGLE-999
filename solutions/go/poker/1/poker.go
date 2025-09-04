// For my Shree DR.MDD
package poker

import (
	"errors"
	"sort"
	"strings"
)

type Card struct {
	num  int
	suit string
}

type Hand struct {
	cards     [5]Card
	score     int
	original  string
	multiples [5]int
}

var faceMap = map[string]int{"A": 14, "K": 13, "Q": 12, "J": 11, "10": 10,
	"9": 9, "8": 8, "7": 7, "6": 6, "5": 5, "4": 4, "3": 3, "2": 2}

func BestHand(sHands []string) ([]string, error) {
	hands := make([]Hand, 0)
	for _, sHand := range sHands {
		if nh, err := NewHand(sHand); err != nil {
			return sHands, err
		} else {
			hands = append(hands, nh)
		}
	}

	sort.Slice(hands, func(i, j int) bool {
		return hands[i].score > hands[j].score
	})

	bestScore := hands[0].score
	best := make([]string, 0, 1)

	for _, h := range hands {
		if h.score == bestScore {
			best = append(best, h.original)
		}
	}
	return best, nil
}

func NewHand(hand string) (Hand, error) {
	h := Hand{original: hand}
	sCards := strings.Fields(hand)
	if len(sCards) != 5 {
		return Hand{}, errors.New("requires five cards")
	}
	for i, sCard := range sCards {
		c, err := parseCard([]rune(sCard))
		if err != nil {
			return h, err
		}
		h.cards[i] = c
	}
	h.calcScore()
	return h, nil
}

func parseCard(card []rune) (Card, error) {
	l := len(card)
	if l < 2 || l > 3 {
		return Card{}, errors.New("invalid card")
	}
	suit := string(card[l-1:])
	num, ok := faceMap[string(card[:l-1])]
	if !ok || !strings.ContainsAny("♤♡♢♧", suit) {
		return Card{}, errors.New("invalid card")
	}
	return Card{num: num, suit: suit}, nil
}

func (h *Hand) calcMultiples() {
	counts := make([]int, len(faceMap)+5)
	for _, c := range h.cards {
		counts[c.num]++
	}
	for _, v := range counts {
		if v > 0 {
			h.multiples[v]++
		}
	}
}

func (h *Hand) straight() bool {
	return h.cards[0].num+1 == h.cards[1].num &&
		h.cards[1].num+1 == h.cards[2].num &&
		h.cards[2].num+1 == h.cards[3].num &&
		(h.cards[3].num+1 == h.cards[4].num ||
			(h.cards[0].num == 2 && h.cards[4].num == 14))
}

func (h *Hand) flush() bool {
	return h.cards[0].suit == h.cards[1].suit &&
		h.cards[1].suit == h.cards[2].suit &&
		h.cards[2].suit == h.cards[3].suit &&
		h.cards[3].suit == h.cards[4].suit
}

func (h *Hand) calcScore() {
	h.calcMultiples()
	sort.Slice(h.cards[:], func(i, j int) bool {
		return h.cards[i].num < h.cards[j].num
	})
	all := h.cards[0].num + h.cards[1].num<<4 + h.cards[2].num<<8 +
		h.cards[3].num<<12 + h.cards[4].num<<16

	switch {
	case h.flush() && h.straight():
		h.score = 8<<24 + h.cards[3].num<<20
	case h.multiples[4] == 1:
		h.score = 7<<24 + h.cards[2].num<<20 + all
	case h.multiples[2] == 1 && h.multiples[3] == 1:
		h.score = 6<<24 + h.cards[2].num<<20 + all
	case h.flush():
		h.score = 5<<24 + all
	case h.straight() && h.cards[0].num == 2 && h.cards[4].num == 14:
		h.score = 4 << 24
	case h.straight():
		h.score = 4<<24 + h.cards[4].num<<20
	case h.multiples[3] == 1:
		h.score = 3<<24 + h.cards[2].num<<20 + all
	case h.multiples[2] == 2:
		h.score = 2<<24 + all
	case h.multiples[2] == 1:
		h.score = 1<<24 + all
	default:
		h.score = all
	}
}
