import java.util.*;
class ProteinTranslator {
    List<String> translate(String rnaSequence) {
        if (rnaSequence.isEmpty()) {
            return new ArrayList<>();
        }
        if (rnaSequence.length() < 3) {
            throw new IllegalArgumentException("Invalid codon");
        }
        String translated = switch (rnaSequence.substring(0, 3)) {
            case "AUG" -> "Methionine";
            case "UUU", "UUC" -> "Phenylalanine";
            case "UUA", "UUG" -> "Leucine";
            case "UCU", "UCC", "UCA", "UCG" -> "Serine";
            case "UAU", "UAC" -> "Tyrosine";
            case "UGU", "UGC" -> "Cysteine";
            case "UGG" -> "Tryptophan";
            case "UAA", "UAG", "UGA" -> "STOP";
            default -> throw new IllegalArgumentException("Invalid codon");
            };
        if (translated.equals("STOP")) {
            return new ArrayList<>();
        }
        List<String> result = translate(rnaSequence.substring(3));
        result.add(0, translated);
        return result;
    }
}