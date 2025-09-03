import java.util.*;
import java.util.stream.IntStream;
class DiamondPrinter {

    List<String> printToList(char a) {
        int length = 2 * (a - 'A') + 1;
        return IntStream.range(0, length).mapToObj(i -> getLine((char) ('A' + length / 2 - Math.abs(i - length / 2)), length - 2)).toList();
    }
    private String getLine(char a, int spaceNum) {
        if (a == 'A') {
            String sideSpace = getSpace((int) Math.floor((float) spaceNum / 2) + 1);
            return sideSpace + a + sideSpace;
        }
        int midSpaceNum = 2 * (a - 'A') - 1;
        String sideSpace = getSpace((spaceNum - midSpaceNum) / 2);
        return sideSpace + a + getSpace(midSpaceNum) + a + sideSpace;
    }
    private String getSpace(int num) {
        return " ".repeat(num);
    }
}