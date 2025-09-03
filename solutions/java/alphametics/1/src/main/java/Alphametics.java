// For my Shree DR.MDD

import java.util.*;
import java.util.stream.IntStream;
import java.util.regex.Pattern;

class Alphametics {
    private Map<Character, Integer> letterMapping = new HashMap<>();
    private final List<Character> lettersInUse;
    private final char[][] operands;
    private final char[] resultWord;

    Alphametics(String puzzleInput) {
        Set<Character> letterSet = new HashSet<>();
        operands = Pattern.compile("[A-Z]+(?=\\s[+=])")
            .matcher(puzzleInput)
            .results()
            .map(m -> m.group().toCharArray())
            .peek(arr -> addCharsToSet(arr, letterSet))
            .toArray(char[][]::new);

        resultWord = Pattern.compile("(?<==\\s)[A-Z]+")
            .matcher(puzzleInput)
            .results()
            .findFirst()
            .orElseThrow()
            .group()
            .toCharArray();

        addCharsToSet(resultWord, letterSet);
        lettersInUse = Collections.unmodifiableList(new ArrayList<>(letterSet));
    }

    Map<Character, Integer> solve() throws UnsolvablePuzzleException {
        backtrackMapping(0);
        return letterMapping;
    }

    private void addCharsToSet(char[] array, Set<Character> set) {
        for (char c : array) set.add(c);
    }

    private boolean backtrackMapping(int index) throws UnsolvablePuzzleException {
        if (index >= lettersInUse.size()) return checkSolution();

        Character letter = lettersInUse.get(index);
        for (int digit = 0; digit < 10; digit++) {
            if (letterMapping.containsValue(digit)) continue;
            letterMapping.put(letter, digit);
            if (backtrackMapping(index + 1)) return true;
            letterMapping.remove(letter);
        }

        if (index == 0) throw new UnsolvablePuzzleException();
        return false;
    }

    private boolean checkSolution() {
        if (letterMapping.get(resultWord[0]) == 0 ||
            Arrays.stream(operands).anyMatch(op -> letterMapping.get(op[0]) == 0)) return false;

        int expected = getWordNumber(letterMapping, resultWord);
        int actual = Arrays.stream(operands)
            .mapToInt(op -> getWordNumber(letterMapping, op))
            .sum();

        return expected == actual;
    }

    private int getWordNumber(Map<Character, Integer> map, char[] word) {
        int len = word.length;
        return IntStream.range(0, len)
            .map(i -> map.get(word[i]) * (int) Math.pow(10, len - 1 - i))
            .sum();
    }
}
