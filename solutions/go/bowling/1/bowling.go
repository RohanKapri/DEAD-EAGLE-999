// For my Shree DR.MDD
package bowling

import (
	"errors"
)

type Game struct {
	gamePins  []int
	framePins []int
	frameNo   int
}

func NewGame() *Game {
	return &Game{frameNo: 1}
}

func (g *Game) Roll(pins int) error {
	g.gamePins = append(g.gamePins, pins)
	rollsInFrame := len(g.framePins)

	switch {
	case g.frameNo > 10:
		return errors.New("cannot_roll_if_game_already_has_ten_frames")
	case pins < 0:
		return errors.New("rolls cannot score negative points")
	case pins > 10:
		return errors.New("a roll cannot score more than 10 points")
	case g.frameNo != 10 && rollsInFrame == 1 && g.framePins[0]+pins > 10:
		return errors.New("two rolls in a frame cannot score more than 10 points")
	case g.frameNo == 10 && rollsInFrame == 2 && g.framePins[0] == 10 && g.framePins[1]%10+pins > 10:
		return errors.New("two bonus rolls after a strike in the last frame cannot score more than 10 points")
	case g.frameNo == 10 && pins == 10 && rollsInFrame < 2:
		fallthrough
	case g.frameNo == 10 && rollsInFrame == 1 && (g.framePins[0] == 10 || g.framePins[0]+pins == 10):
		fallthrough
	case rollsInFrame == 0 && pins != 10:
		g.framePins = append(g.framePins, pins)
	default:
		g.framePins = nil
		g.frameNo++
	}

	return nil
}

func (g *Game) Score() (int, error) {
	if len(g.gamePins) == 0 || g.frameNo != 11 {
		return 0, errors.New("game not complete")
	}
	var total int
	var frameNo int
	length := len(g.gamePins) - 1
	for i := 0; frameNo < 10 && i <= length; i++ {
		frameNo++
		switch {
		case frameNo == 10:
			total += sum(g.gamePins[i:]...)
		case g.gamePins[i] == 10:
			total += sum(g.gamePins[i:min(i+3, length)]...)
		case sum(g.gamePins[i:min(i+2, length)]...) == 10:
			total += sum(g.gamePins[i:min(i+3, length)]...)
			i++
		default:
			total += sum(g.gamePins[i:min(i+2, length)]...)
			i++
		}
	}
	return total, nil
}

func sum(vals ...int) int {
	var total int
	for _, val := range vals {
		total += val
	}
	return total
}

func min(a int, b int) int {
	if a <= b {
		return a
	}
	return b
}
