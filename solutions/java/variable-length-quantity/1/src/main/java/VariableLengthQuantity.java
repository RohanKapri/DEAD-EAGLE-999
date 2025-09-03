// For my Shree DR.MDD

import java.util.List;
import java.util.LinkedList;

class VariableLengthQuantity {

    List<String> encode(List<Long> inputNumbers) {
        List<String> encodedResult = new LinkedList<>();
        inputNumbers.stream().forEach(number -> {
            List<String> tempChunks = new LinkedList<>();
            boolean isLast = true;
            do {
                int segment = (int) (number & 0x7F);
                number >>>= 7;
                if (isLast) {
                    isLast = false;
                } else {
                    segment |= 0x80;
                }
                tempChunks.add(0, toHex(segment));
            } while (number != 0);
            encodedResult.addAll(tempChunks);
        });
        return encodedResult;
    }

    List<String> decode(List<Long> byteSequence) {
        List<String> decodedResult = new LinkedList<>();
        int combinedChunk = 0;
        for (int index = 0; index < byteSequence.size(); index++) {
            int currentVal = byteSequence.get(index).intValue();
            combinedChunk = (combinedChunk << 7) | (currentVal & 0x7F);
            if ((currentVal & 0x80) == 0) {
                decodedResult.add(toHex(combinedChunk));
                combinedChunk = 0;
            } else if (index == byteSequence.size() - 1) {
                throw new IllegalArgumentException("Invalid variable-length quantity encoding");
            }
        }
        return decodedResult;
    }

    private String toHex(int val) {
        return "0x" + Integer.toHexString(val);
    }
}
