import java.util.stream.IntStream;
class IsbnVerifier {

    boolean isValid(String stringToVerify) {
        if (!stringToVerify.matches("^\\d{9}[\\dX]$|^\\d{1,5}-\\d{1,7}-\\d{1,6}-[\\dX]$")) return false;
        int[] digits = stringToVerify.replaceAll("-", "").chars().map(c -> c == 'X' ? 10 : Character.getNumericValue(c)).toArray();
        return formulaResult(digits) % 11 == 0;
    }
    private int formulaResult(int[] digits) {
        return IntStream.range(0, digits.length).map(i -> digits[i] * (digits.length - i)).sum();
    }
}