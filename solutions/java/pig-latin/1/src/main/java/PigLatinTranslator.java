public class PigLatinTranslator {
    public static String translate(String word) {
        return word.replaceAll("(?<a>(?!yt|xr)(qu|[^aeiou ])(qu|[^aeiouy ])*)?(?<b>\\w+)", "${b}${a}ay");
    }
}