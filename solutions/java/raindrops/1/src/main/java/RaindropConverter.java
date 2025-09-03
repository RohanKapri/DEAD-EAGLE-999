import java.util.Map;
class RaindropConverter {
    final private Map<Integer, String> TRANSLATION = Map.of(3, "Pling", 5, "Plang", 7, "Plong");
    String convert(int number) {
        return TRANSLATION.keySet().stream().sorted().filter(k -> number % k == 0).map(k -> TRANSLATION.get(k)).reduce(String::concat).orElse(String.valueOf(number));
    }
}