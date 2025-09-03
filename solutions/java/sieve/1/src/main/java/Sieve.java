import java.util.List;
import java.util.stream.IntStream;
class Sieve {
    private final int maxPrime;
    Sieve(int maxPrime) {
        this.maxPrime = maxPrime;
    }

    List<Integer> getPrimes() {
        List<Integer> numbers = IntStream.rangeClosed(2, maxPrime).boxed().toList();
        boolean[] marks = new boolean[numbers.size()];
        for (int i = 0; i < numbers.size(); i++) {
            if (!marks[i]) {
                for (int j = i * 2 + 2; j < numbers.size(); j += i + 2) {
                    marks[j] = true;
                }
            }
        }
        return IntStream.range(0, numbers.size()).filter(i -> !marks[i]).mapToObj(i -> numbers.get(i)).toList();
    }
}