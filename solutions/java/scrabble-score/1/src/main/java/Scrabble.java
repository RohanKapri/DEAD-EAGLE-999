import java.util.*;
class Scrabble {
    private final Map<List<Character>, Integer> TRANSLATIONS = Map.of(
        List.of('A', 'E', 'I', 'O', 'U', 'L', 'N', 'R', 'S', 'T'), 1,
        List.of('D', 'G'), 2,
        List.of('B', 'C', 'M', 'P'), 3,
        List.of('F', 'H', 'V', 'W', 'Y'), 4,
        List.of('K'), 5,
        List.of('J', 'X'), 8,
        List.of('Q', 'Z'), 10
    );
    private final int score;
    Scrabble(String word) {
        score = word.toUpperCase().chars().map(i -> 
            TRANSLATIONS.entrySet().stream()
            .filter(e -> e.getKey().contains((char) i)).map(Map.Entry::getValue).findFirst().get())
        .sum();
    }
    int getScore() {
        return score;
    }

}