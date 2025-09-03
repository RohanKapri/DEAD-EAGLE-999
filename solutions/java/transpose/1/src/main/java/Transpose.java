import java.util.*;
import java.util.stream.*;
public class Transpose {
    public String transpose(String toTranspose) {
        String[] toTransposeRows = toTranspose.split("\n");
        int length = toTransposeRows.length;
        int maxRowLength = Arrays.stream(toTransposeRows).mapToInt(String::length).max().orElse(0);
        char[][] transposedMatrix = new char[maxRowLength][length];
        for (int i = 0; i < length; i++) {
            String currentRow = toTransposeRows[i];
            for (int j = 0; j < maxRowLength; j++) {
                transposedMatrix[j][i] = currentRow.length() > j ? currentRow.charAt(j) : '\0';
            }
        }
        return Arrays.stream(transposedMatrix).map(a -> new String(a).replaceFirst("(?<=[^\0])\0+$", "").replace('\0', ' ')).collect(Collectors.joining("\n"));
    }
}