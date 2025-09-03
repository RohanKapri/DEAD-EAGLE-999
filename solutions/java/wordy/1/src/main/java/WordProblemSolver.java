import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.regex.*;
class WordProblemSolver {
    int solve(final String wordProblem) {
        final String[] OPERATIONS = {"plus", "minus", "multiplied by", "divided by"};
        final String OPERATIONS_MATCHER = Arrays.stream(OPERATIONS).collect(Collectors.joining("|"));
        Matcher wholeMatcher = Pattern.compile("^What is (-?\\d+)(?: (" + OPERATIONS_MATCHER + ") (-?\\d+))*\\?").matcher(wordProblem);
        if (!wholeMatcher.find()) throw new IllegalArgumentException("I'm sorry, I don't understand the question!");
        int result = Integer.parseInt(wholeMatcher.group(1));
        Matcher opMatcher = Pattern.compile("(" + OPERATIONS_MATCHER + ") (-?\\d+)").matcher(wordProblem);
        while (opMatcher.find()) {
            String operation = opMatcher.group(1);
            int operand = Integer.parseInt(opMatcher.group(2));
            switch (operation) {
                case "plus" -> result += operand;
                case "minus" -> result -= operand;
                case "multiplied by" -> result *= operand;
                case "divided by" -> result /= operand;
            }
        }
        return result;
    }
}