class RotationalCipher {
    private final int shiftKey;
    RotationalCipher(int shiftKey) {
        this.shiftKey = shiftKey;
    }

    String rotate(String data) {
        return data.chars()
            .map(this::shift)
            .collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append)
            .toString();
    }
    private int shift(int c) {
        if (!Character.isLetter(c)) {
            return c;
        }
        char base = Character.isUpperCase(c) ? 'A' : 'a';
        return base + (c - base + shiftKey) % 26;
    }
}