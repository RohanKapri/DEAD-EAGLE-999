import java.util.*;
class BookStore {
    private static final double[] COSTS = {8.0, 15.2, 21.6, 25.6, 30.0};
    double calculateBasketCost(List<Integer> books) {
        Set<Double> results = new HashSet<>();
        int[] frequency = new int[5];
        books.forEach(i -> frequency[i - 1]++);
        backtrack(results, frequency, 0.0);
        return Collections.min(results);
    }
    private void backtrack(Set<Double> results, int[] frequency, double currentCost) {
        if (Arrays.stream(frequency).allMatch(i -> i == 0)) {
            results.add(currentCost);
            return;
        }
        int[] updatedFrequency = Arrays.copyOf(frequency, frequency.length);
        Arrays.sort(updatedFrequency);
        for (int i = 0; i < updatedFrequency.length; i++) {
            int reverseIndex = updatedFrequency.length - i - 1;
            if (updatedFrequency[reverseIndex] == 0) break;
            updatedFrequency[reverseIndex]--;
            backtrack(results, updatedFrequency, currentCost + COSTS[i]);
        }
    }
}