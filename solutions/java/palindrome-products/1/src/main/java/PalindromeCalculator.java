import java.util.*;

class PalindromeCalculator {
    
    SortedMap<Long, List<List<Integer>>> getPalindromeProductsWithFactors(int minFactor, int maxFactor) {
        if (minFactor > maxFactor) throw new IllegalArgumentException("invalid input: min must be <= max");
        SortedMap<Long, List<List<Integer>>> result = new TreeMap<>();
        for (int i = minFactor; i <= maxFactor; i++) {
            for (int j = i; j <= maxFactor; j++) {
                long product = i * j;
                if (isPalindrome(product)) {
                    result.computeIfAbsent(product, k -> new ArrayList<>()).add(List.of(i, j));
                }
            }
        }
        return result;
    }

    private boolean isPalindrome(long number) {
        String numberString = String.valueOf(number);
        return numberString.equals(new StringBuilder(numberString).reverse().toString());
    }
}