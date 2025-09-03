import java.util.*;
class NucleotideCounter {
    private final List<Character> NUCLEOTIDES = List.of('A', 'C', 'G', 'T');
    private final Map<Character, Integer> nucleotideCounts = new HashMap<>();
    NucleotideCounter(String sequence) {
        final int[] counts = new int[NUCLEOTIDES.size()];
        sequence.chars().forEach(c -> {
            int index = NUCLEOTIDES.indexOf((char) c);
            if (index == -1) {
                throw new IllegalArgumentException();
            } else {
                counts[index]++;
            }
        });
        for (int i = 0; i < NUCLEOTIDES.size(); i++) {
            nucleotideCounts.put(NUCLEOTIDES.get(i), counts[i]);
        }
    }
    Map<Character, Integer> nucleotideCounts() {
        return nucleotideCounts;
    }
}