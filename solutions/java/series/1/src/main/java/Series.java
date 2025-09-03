import java.util.List;
import java.util.stream.IntStream;
class Series {
    private final String string;
    Series(String string) {
        if (string.isEmpty()) throw new IllegalArgumentException("series cannot be empty");
        this.string = string;
    }

    List<String> slices(int num) {
        int length = string.length();
        if (num > length) throw new IllegalArgumentException("slice length cannot be greater than series length");
        if (num <= 0) throw new IllegalArgumentException("slice length cannot be negative or zero");
        return IntStream.rangeClosed(0, length - num).mapToObj(i -> string.substring(i, i + num)).toList();
    }
}