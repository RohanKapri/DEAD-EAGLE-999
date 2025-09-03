import java.util.*;
class Anagram {
    private final String word;
    public Anagram(String word) {
        this.word = word;
    }

    public List<String> match(List<String> candidates) {
        int[] sortedWord = getSorted(word);
        return candidates.stream().filter(s -> !s.equalsIgnoreCase(word) && Arrays.equals(sortedWord, getSorted(s))).toList();
    }
    
    private int[] getSorted(String word) {
        return word.toLowerCase().chars().sorted().toArray();
    }
}