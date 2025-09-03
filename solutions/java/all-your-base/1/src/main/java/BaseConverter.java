import java.util.*;
class BaseConverter {
    final int numInDecimal;
    BaseConverter(int originalBase, int[] originalDigits) {
        validateBase(originalBase);
        int result = 0;
        for (int i = 0; i < originalDigits.length; i++) {
            int currentDigit = originalDigits[i];
            if (currentDigit < 0) throw new IllegalArgumentException("Digits may not be negative.");
            if (currentDigit >= originalBase) throw new IllegalArgumentException("All digits must be strictly less than the base.");
            result += currentDigit * Math.pow(originalBase, originalDigits.length - i - 1);
        }
        numInDecimal = result;
    }
    int[] convertToBase(int newBase) {
        validateBase(newBase);
        List<Integer> newDigits = new LinkedList<>();
        int originalNum = numInDecimal;
        while (originalNum != 0) {
            newDigits.add(0, originalNum % newBase);
            originalNum /= newBase;
        }
        if (newDigits.isEmpty()) return new int[]{0};
        return newDigits.stream().mapToInt(i -> i).toArray();
    }
    private void validateBase(int base) {
        if (base < 2) throw new IllegalArgumentException("Bases must be at least 2.");
    }
}