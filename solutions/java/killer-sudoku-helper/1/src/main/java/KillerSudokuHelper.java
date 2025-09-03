import java.util.ArrayList;
import java.util.List;
import java.util.stream.IntStream;
public class KillerSudokuHelper {
    List<List<Integer>> combinationsInCage(Integer cageSum, Integer cageSize, List<Integer> exclude) {
        List<List<Integer>> result = new ArrayList<>();
        generateCombinations(1, cageSum, cageSize, new ArrayList<>(), exclude, result);
        return result;
    }
    List<List<Integer>> combinationsInCage(Integer cageSum, Integer cageSize) {
        List<List<Integer>> result = new ArrayList<>();
        generateCombinations(1, cageSum, cageSize, new ArrayList<>(), new ArrayList<>(), result);
        return result;
    }
    private void generateCombinations(int start, int sumLeft, int cageSize, List<Integer> current, List<Integer> exclude, List<List<Integer>> result) {
        if (current.size() == cageSize) {
            if (sumLeft == 0) result.add(new ArrayList<>(current));
            return;
        }
        IntStream.range(start, 10).filter(i -> !exclude.contains(i) && i <= sumLeft).forEach(i -> {
            current.add(i);
            generateCombinations(i + 1, sumLeft - i, cageSize, current, exclude, result);
            current.removeLast();
        });
    }
}