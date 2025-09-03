import java.util.*;
import java.util.stream.*;
class Flattener {

    List<Object> flatten(List<?> list) {
        return list.stream().filter(Objects::nonNull).flatMap(e -> e instanceof List ? flatten((List)e).stream() : Stream.of(e)).toList();
    }
}