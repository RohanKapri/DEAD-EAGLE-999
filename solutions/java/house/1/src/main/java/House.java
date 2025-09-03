import java.util.stream.*;
class House {
    private final String[] SUBJECTS = {"house that Jack built.", "malt", "rat", "cat", "dog", "cow with the crumpled horn", "maiden all forlorn", "man all tattered and torn", "priest all shaven and shorn", "rooster that crowed in the morn", "farmer sowing his corn", "horse and the hound and the horn"}, ACTIONS = {"", "lay in", "ate", "killed", "worried", "tossed", "milked", "kissed", "married", "woke", "kept", "belonged to"};
    String verse(int verse) {
        verse--;
        return "This is the " + SUBJECTS[verse] + getVerse(verse);
    }
    private String getVerse(int verse) {
        return verse == 0 ? "" : " that " + ACTIONS[verse] + " the " + SUBJECTS[verse - 1] + getVerse(verse - 1);
    }
    String verses(int startVerse, int endVerse) {
        return IntStream.range(startVerse, endVerse + 1).mapToObj(this::verse).collect(Collectors.joining("\n"));
    }
    String sing() {
        return verses(1, SUBJECTS.length);
    }
}