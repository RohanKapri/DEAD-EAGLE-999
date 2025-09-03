import java.util.stream.IntStream;
public class AffineCipher {
    public String encode(String text, int coefficient1, int coefficient2){
        checkCoprimeWith26(coefficient1);
        return text.toLowerCase().chars().filter(Character::isLetterOrDigit).map(c -> {
            if (Character.isDigit(c)) return c;
            return 'a' + (coefficient1 * getAlphabetNum(c) + coefficient2) % 26;
        }).collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString().replaceAll("(.{5})(?=.)", "$1 ");
    }
    public String decode(String text, int coefficient1, int coefficient2){
        checkCoprimeWith26(coefficient1);
        final int x = IntStream.iterate(1, n -> coefficient1 * n % 26 != 1, n -> n + 1).reduce(0, (n1, n2) -> n2) + 1;
        return text.toLowerCase().chars().filter(Character::isLetterOrDigit).map(c -> {
            if (Character.isDigit(c)) return c;
            return 'a' + (x * (getAlphabetNum(c) - coefficient2) % 26 + 26) % 26;
        }).collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
    }
    private void checkCoprimeWith26(int num) {
        if (num % 2 == 0 || num % 13 == 0) throw new IllegalArgumentException("Error: keyA and alphabet size must be coprime.");
    }
    private int getAlphabetNum(int charCode) {
        return 25 - ('z' - charCode);
    }
}