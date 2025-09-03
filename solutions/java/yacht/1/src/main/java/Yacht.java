// For my Shree DR.MDD

import java.util.Arrays;
import java.util.stream.IntStream;

class Yacht {
    private final int score;

    Yacht(int[] rolledDice, YachtCategory category) {
        int totalDice = Arrays.stream(rolledDice).sum();
        switch (category) {
            case ONES:
            case TWOS:
            case THREES:
            case FOURS:
            case FIVES:
            case SIXES:
                int faceValue = category.ordinal();
                score = (int) Arrays.stream(rolledDice).filter(d -> d == faceValue).count() * faceValue;
                break;
            case FULL_HOUSE:
                score = hasFrequency(rolledDice, 3, true) && hasFrequency(rolledDice, 2, true) ? totalDice : 0;
                break;
            case FOUR_OF_A_KIND:
                score = hasFrequency(rolledDice, 4, false) ? 4 * getQuadValue(rolledDice) : 0;
                break;
            case LITTLE_STRAIGHT:
                score = checkStraight(rolledDice, 1);
                break;
            case BIG_STRAIGHT:
                score = checkStraight(rolledDice, 2);
                break;
            case CHOICE:
                score = totalDice;
                break;
            default:
                score = hasFrequency(rolledDice, 5, true) ? 50 : 0;
        }
    }

    int score() {
        return score;
    }

    private boolean hasFrequency(int[] rolledDice, int freq, boolean exact) {
        return Arrays.stream(rolledDice).anyMatch(d -> {
            int count = (int) Arrays.stream(rolledDice).filter(x -> x == d).count();
            return exact ? count == freq : count >= freq;
        });
    }

    private int getQuadValue(int[] rolledDice) {
        return rolledDice[0] == rolledDice[1] ? rolledDice[0] : rolledDice[2];
    }

    private int checkStraight(int[] rolledDice, int startVal) {
        return IntStream.range(startVal, startVal + 5).allMatch(val -> Arrays.stream(rolledDice).anyMatch(d -> d == val)) ? 30 : 0;
    }
}
