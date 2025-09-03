import java.util.Map;
import java.util.regex.Pattern;
import java.util.stream.Collectors;
class WordCount {
    public Map<String, Integer> phrase(String input) {
        return Pattern.compile("\\w+('*\\w+)*").matcher(input).results().collect(Collectors.toMap(k -> k.group().toLowerCase(), v -> 1, Integer::sum));
    }
}