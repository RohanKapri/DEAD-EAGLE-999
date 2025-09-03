import java.util.stream.IntStream;
class LuhnValidator {

    boolean isValid(String candidate) {
        final String fixedCandidate = candidate.replace(" ", "");
        
        if (fixedCandidate.length() <= 1) return false;
        
        return IntStream.range(0, fixedCandidate.length()).map(i -> {
            int index = fixedCandidate.length() - i - 1;
            int current = Character.getNumericValue(fixedCandidate.charAt(index));
            if ((fixedCandidate.length() - index) % 2 == 0) {
                int currentDoubled = 2 * current;
                return currentDoubled < 10 ? currentDoubled : currentDoubled - 9;
            }
            return current;
        }).sum() % 10 == 0;
    }

}