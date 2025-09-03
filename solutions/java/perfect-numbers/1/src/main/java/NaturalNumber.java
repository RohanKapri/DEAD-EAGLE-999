import java.util.stream.IntStream;
class NaturalNumber {
    final Classification classification;
    NaturalNumber(int number) {
        if (number < 1) {
            throw new IllegalArgumentException("You must supply a natural number (positive integer)");
        }
        classification = switch ((int) Math.signum(IntStream.range(1, number / 2 + 1).filter(i -> number % i == 0).sum() - number)) {
            case 1 -> Classification.ABUNDANT;
            case 0 -> Classification.PERFECT;
            default -> Classification.DEFICIENT;
            };
    }

    Classification getClassification() {
        return classification;
    }
}
