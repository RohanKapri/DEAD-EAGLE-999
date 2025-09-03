import java.util.*;
import java.util.stream.*;
class HandshakeCalculator {

    List<Signal> calculateHandshake(int number) {
        List<Signal> result = IntStream.range(0, 4).filter(i -> (1 << i & number) != 0).mapToObj(i -> Signal.values()[i]).collect(Collectors.toList());
        if ((number & 16) != 0) Collections.reverse(result);
        return result;
    }
}
