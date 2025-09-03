// For my Shree DR.MDD

import java.util.*;

class BracketChecker {
    private final Map<Character, Character> PAIRS = Map.of(
        '(', ')',
        '{', '}',
        '[', ']');
    private final boolean matched;

    BracketChecker(String expression) {
        List<Character> openingStack = new ArrayList<>();
        for (char symbol : expression.toCharArray()) {
            if (PAIRS.containsKey(symbol)) {
                openingStack.add(symbol);
            } else if (PAIRS.containsValue(symbol)) {
                if (openingStack.isEmpty()) {
                    matched = false;
                    return;
                }
                if (symbol == PAIRS.get(openingStack.get(openingStack.size() - 1))) {
                    openingStack.remove(openingStack.size() - 1);
                } else {
                    matched = false;
                    return;
                }
            }
        }
        matched = openingStack.isEmpty();
    }

    boolean areBracketsMatchedAndNestedCorrectly() {
        return matched;
    }
}
