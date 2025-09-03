import java.util.*;

class PrimeFactorsCalculator {

    List<Long> calculatePrimeFactorsOf(long number) {
        List<Long> result = new ArrayList<>();
        if (number == 1) return result;
        long i = 2;
        while (i <= (long) Math.sqrt(number)) {
            if (number % i == 0) {
                result.add(i);
                number /= i;
            } else i++;
        }
        result.add(number);
        return result;
    }

}