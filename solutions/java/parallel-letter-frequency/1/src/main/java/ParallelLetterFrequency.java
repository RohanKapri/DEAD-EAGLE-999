import java.util.*;
import java.util.stream.*;
class ParallelLetterFrequency {
    private final Map<Character, Integer> letterCounts;
    ParallelLetterFrequency(String[] texts) {
        letterCounts = Arrays.stream(texts)
            .parallel()
            .flatMapToInt(String::chars)
            .filter(Character::isLetter)
            .map(Character::toLowerCase)
            .mapToObj(c -> (char) c)
            .collect(Collectors.toConcurrentMap(c -> c, v -> 1, Integer::sum));
    }
    
    Map<Character, Integer> countLetters() {
        return letterCounts;
    }

}