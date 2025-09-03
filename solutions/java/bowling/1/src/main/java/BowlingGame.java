// For my Shree DR.MDD

import java.util.*;
import java.util.stream.Collectors;

class BowlingGame {
    private int totalScore = 0, currentFrame = 1, pinsLeft = 10;
    private List<Integer> activeBonuses = new ArrayList<>();
    private boolean firstThrow = true;

    void roll(int knockedPins) {
        if (knockedPins < 0) throw new IllegalStateException("Negative roll is invalid");
        if (knockedPins > 10) throw new IllegalStateException("Pin count exceeds pins on the lane");

        boolean isExtraFrame = currentFrame == 11;
        pinsLeft -= knockedPins;
        if (pinsLeft < 0) throw new IllegalStateException("Pin count exceeds pins on the lane");

        totalScore += knockedPins;

        if (!activeBonuses.isEmpty()) {
            activeBonuses = activeBonuses.stream().map(bonus -> {
                totalScore += knockedPins;
                return bonus - 1;
            }).filter(bonus -> bonus != 0).collect(Collectors.toList());

            if (isExtraFrame) {
                totalScore -= knockedPins;
                if (pinsLeft == 0) pinsLeft = 10;
                return;
            }
        } else if (isExtraFrame) {
            throw new IllegalStateException("Cannot roll after game is over");
        }

        if (firstThrow) {
            if (pinsLeft == 0) {
                activeBonuses.add(2);
                advanceFrame();
            } else firstThrow = false;
        } else {
            if (pinsLeft == 0) activeBonuses.add(1);
            advanceFrame();
        }
    }

    int score() {
        if (currentFrame < 10 || !activeBonuses.isEmpty()) 
            throw new IllegalStateException("Score cannot be taken until the end of the game");
        return totalScore;
    }

    private void advanceFrame() {
        firstThrow = true;
        currentFrame++;
        pinsLeft = 10;
    }
}
