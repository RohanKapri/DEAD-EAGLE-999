import java.util.Map;
import java.util.stream.Collectors;
class RnaTranscription {
    final Map<String, String> transcription = Map.of(
        "G", "C",
        "C", "G",
        "T", "A",
        "A", "U");
    String transcribe(String dnaStrand) {
        return dnaStrand.isEmpty() ? "" : dnaStrand.chars().mapToObj(c -> transcription.get(String.valueOf((char) c))).collect(Collectors.joining());
    }
    
}