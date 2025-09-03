import java.util.List;
class Knapsack {
    int maximumValue(int maximumWeight, List<Item> items) {
        int[] maximumValue = {0};
        backtrack(maximumValue, maximumWeight, items, 0, 0, 0);
        return maximumValue[0];
    }
    private void backtrack(int[] maximumValue, int maximumWeight, List<Item> items, int startIndex, int currentWeight, int currentValue) {
        if (currentWeight <= maximumWeight) {
            maximumValue[0] = Math.max(maximumValue[0], currentValue);
        } else {
            return;
        }
        for (int i = startIndex; i < items.size(); i++) {
            backtrack(maximumValue, maximumWeight, items, i + 1, currentWeight + items.get(i).weight, currentValue + items.get(i).value);
        }
    }
}