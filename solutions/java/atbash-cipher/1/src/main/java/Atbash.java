class Atbash {

    String encode(String input) {
        return flip(input, "\\W").replaceAll("(.{5})(?=.)", "$1 ");
    }

    String decode(String input) {
        return flip(input, "\\s");
    }

    private String flip(String input, String exclude) {
        return input.replaceAll(exclude, "").toLowerCase().chars().map(i -> Character.isLetter(i) ? 'a' + 'z' - i : i).collect(StringBuilder::new, StringBuilder::appendCodePoint, StringBuilder::append).toString();
    }
}