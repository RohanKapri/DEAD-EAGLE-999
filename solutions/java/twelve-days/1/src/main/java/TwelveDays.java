import java.util.Arrays;
import java.util.stream.Collectors;
import java.util.stream.IntStream;
class TwelveDays {
    private final String TEMPLATE = "On the %s day of Christmas my true love gave to me: %s.\n"
    , SUFFIX = "th"
    , FIRST_GIFT = "a Partridge in a Pear Tree";
    private final String[] DAYS = {"first", "second", "third", "four", "fif", "six", "seven", "eigh", "nin", "ten", "eleven", "twelf"}
    , GIFTS = {"twelve Drummers Drumming", "eleven Pipers Piping", "ten Lords-a-Leaping", "nine Ladies Dancing", "eight Maids-a-Milking", "seven Swans-a-Swimming", "six Geese-a-Laying", "five Gold Rings", "four Calling Birds", "three French Hens", "two Turtle Doves"};
    
    String verse(int verseNumber) {
        return String.format(TEMPLATE
            , DAYS[verseNumber - 1] + (verseNumber < 4 ? "" : SUFFIX)
            , verseNumber == 1 ? FIRST_GIFT : Arrays.stream(GIFTS).skip(GIFTS.length - verseNumber + 1).collect(Collectors.joining(", ")) + ", and " + FIRST_GIFT);
    }
    String verses(int startVerse, int endVerse) {
        return IntStream.rangeClosed(startVerse, endVerse).mapToObj(this::verse).collect(Collectors.joining("\n"));
    }
    
    String sing() {
        return verses(1, DAYS.length);
    }
}