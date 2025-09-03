import java.util.stream.IntStream;
class Proverb {
    private final String cited;
    Proverb(String[] words) {
        if (words.length == 0) {
            cited = "";
        }
        else if (words.length == 1) {
            cited = "And all for the want of a " + words[0] + ".";
        }
        else {
            StringBuilder sb = new StringBuilder();
            IntStream.range(0, words.length - 1)
                .forEach(i -> sb.append("For want of a " + words[i] + " the " + words[i + 1] + " was lost.\n"));
            cited = sb.toString() + "And all for the want of a " + words[0] + ".";
        }
    }

    String recite() {
        return cited;
    }
}