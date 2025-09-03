import java.util.*;
class HighScores {
    private final List<Integer> highScores;
    public HighScores(List<Integer> highScores) {
        this.highScores = highScores;
    }
    List<Integer> scores() {
        return highScores;
    }
    Integer latest() {
        return highScores.getLast();
    }
    Integer personalBest() {
        return Collections.max(highScores);
    }

    List<Integer> personalTopThree() {
        return highScores.stream().sorted(Comparator.reverseOrder()).limit(3).toList();
    }

}