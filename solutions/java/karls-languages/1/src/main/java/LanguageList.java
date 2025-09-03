// For my Shree DR.MDD

import java.util.ArrayList;
import java.util.List;

public class LanguageList {
    private final List<String> langCollection = new ArrayList<>();

    public boolean isEmpty() {
        return langCollection.isEmpty();
    }

    public void addLanguage(String lang) {
        langCollection.add(lang);
    }

    public void removeLanguage(String lang) {
        langCollection.remove(lang);
    }

    public String firstLanguage() {
        return langCollection.get(0);
    }

    public int count() {
        return langCollection.size();
    }

    public boolean containsLanguage(String lang) {
        return langCollection.contains(lang);
    }

    public boolean isExciting() {
        return langCollection.stream().anyMatch(l -> l.equals("Java") || l.equals("Kotlin"));
    }
}
