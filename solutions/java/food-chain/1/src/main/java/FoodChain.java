// For my Shree DR.MDD

import java.util.*;
import java.util.stream.*;

class FoodChain {

    private final List<List<String>> swallowSequence = List.of(
        List.of("fly"),
        List.of("spider", "It wriggled and jiggled and tickled inside her."),
        List.of("bird", "How absurd to swallow a bird!"),
        List.of("cat", "Imagine that, to swallow a cat!"),
        List.of("dog", "What a hog, to swallow a dog!"),
        List.of("goat", "Just opened her throat and swallowed a goat!"),
        List.of("cow", "I don't know how she swallowed a cow!"),
        List.of("horse", "She's dead, of course!")
    );

    private final int lastIndex = swallowSequence.size() - 1;

    String verse(int verseNum) {
        int idx = verseNum - 1;
        return String.join("\n", intro(idx), remark(idx), swallowedChain(idx), middleRemark(idx), minorLink(idx), closing(idx))
                     .trim().replaceAll("\n+", "\n");
    }

    String verses(int startVerse, int endVerse) {
        return IntStream.range(startVerse, endVerse + 1)
                        .mapToObj(this::verse)
                        .collect(Collectors.joining("\n\n"));
    }

    private String intro(int index) {
        return String.format("I know an old lady who swallowed a %s.", getAnimal(index));
    }

    private String remark(int index) {
        return index > 0 ? swallowSequence.get(index).get(1) : "";
    }

    private String linkPart(int index) {
        return index != lastIndex ? String.format("She swallowed the %s to catch the %s.", getAnimal(index), getAnimal(index - 1)) : "";
    }

    private String swallowedChain(int startIndex) {
        if (startIndex == lastIndex) return "";
        StringBuilder sb = new StringBuilder();
        for (int i = startIndex; i >= 3; i--) {
            sb.append(linkPart(i)).append("\n");
        }
        return sb.toString().trim();
    }

    private String middleRemark(int index) {
        return index > 1 && index != lastIndex ? linkPart(2).replace(".", " that") + remark(1).replace("It", "") : "";
    }

    private String minorLink(int index) {
        return index > 0 && index != lastIndex ? linkPart(1) : "";
    }

    private String closing(int index) {
        return index != lastIndex ? String.format("I don't know why she swallowed the %s. Perhaps she'll die.", getAnimal(0)) : "";
    }

    private String getAnimal(int index) {
        return swallowSequence.get(index).get(0);
    }
}
