import java.util.*;
class Robot {
    private String name;
    private static Set<String> existingNames = new HashSet<>();
    public Robot() {
        name = null;
        reset();
    }
    String getName() {
        return name;
    }
    void reset() {
        String newName;
        do {
            newName = getRandomLetter() + getRandomLetter() + getRandomInt(10) + getRandomInt(10) + getRandomInt(10);
        } while (existingNames.contains(newName));
        existingNames.remove(name);
        existingNames.add(newName);
        name = newName;
    }
    private int getRandomInt(int end) {
        return (int) (Math.random() * end);
    }
    private String getRandomLetter() {
        return String.valueOf((char) ('A' + getRandomInt(26)));
    }
}