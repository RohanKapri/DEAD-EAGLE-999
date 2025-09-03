class IsogramChecker {

    boolean isIsogram(String phrase) {
        phrase = phrase.toLowerCase().replaceAll("[-\s]", "");
        return phrase.chars().distinct().count() == phrase.length();
    }

}