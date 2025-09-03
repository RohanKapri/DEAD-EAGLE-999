import java.util.stream.IntStream;
class PrimeCalculator {
    int nth(int nth) {
        return IntStream.iterate(2, n -> n + 1)
            .filter(this::isPrime)
            .skip(nth - 1)
            .findFirst()
            .orElseThrow(IllegalArgumentException::new);
    }
    boolean isPrime(int num) {
        return IntStream.rangeClosed(2, (int) Math.sqrt(num))
            .allMatch(i -> num % i != 0);
    }
}