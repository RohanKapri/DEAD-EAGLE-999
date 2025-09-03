import java.util.stream.IntStream;
class LargestSeriesProductCalculator {
    private final String inputNumber;
    LargestSeriesProductCalculator(String inputNumber) {
        if (!inputNumber.matches("\\d*")) {
            throw new IllegalArgumentException("String to search may only contain digits.");
        }
        this.inputNumber = inputNumber;
    }
    long calculateLargestProductForSeriesLength(int numberOfDigits) {
        if (numberOfDigits < 0) {
            throw new IllegalArgumentException("Series length must be non-negative.");
        }
        if (numberOfDigits > inputNumber.length()) {
            throw new IllegalArgumentException("Series length must be less than or equal to the length of the string to search.");
        }
        return IntStream.rangeClosed(0, inputNumber.length() - numberOfDigits)
            .mapToLong(i -> inputNumber.substring(i, i + numberOfDigits)
                .chars()
                .mapToLong(Character::getNumericValue)
                .reduce(1, Math::multiplyExact))
            .max()
            .orElse(0);
    }
}