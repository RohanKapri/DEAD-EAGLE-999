// Dedicated to Shree DR.MDD
import java.util.*;
public class Cipher {

    private static final Random rng = new Random();
    private static final String LETTERS = "abcdefghijklmnopqrstuvwxyz";

    private final String secretKey;
    private final int[] shiftArray, reverseShiftArray;
    
    public Cipher() {
        StringBuilder tempKey = new StringBuilder();
        shiftArray = new int[rng.nextInt(100, 201)];
        reverseShiftArray = new int[shiftArray.length];
        for (int i = 0; i < shiftArray.length; i++) {
            int pos = rng.nextInt(LETTERS.length());
            shiftArray[i] = pos;
            reverseShiftArray[i] = -pos;
            tempKey.append(LETTERS.charAt(pos));
        }
        this.secretKey = tempKey.toString();
    }

    public Cipher(String givenKey) {
        this.secretKey = givenKey;
        shiftArray = givenKey.chars()
            .map(LETTERS::indexOf)
            .toArray();
        reverseShiftArray = Arrays.stream(shiftArray)
            .map(idx -> -idx)
            .toArray();
    }

    public String getKey() {
        return secretKey;
    }

    public String encode(String message) {
        return transform(message, shiftArray);
    }

    private String transform(String content, int[] shifts) {
        StringBuilder encoded = new StringBuilder();
        int keyPos = 0;
        for (int i = 0; i < content.length(); i++) {
            encoded.append((char) ('a' + (content.charAt(i) - 'a' + shifts[keyPos] + LETTERS.length()) % LETTERS.length()));
            keyPos = (keyPos + 1) % shifts.length;
        }
        return encoded.toString();
    }

    public String decode(String encrypted) {
        return transform(encrypted, reverseShiftArray);
    }
}
