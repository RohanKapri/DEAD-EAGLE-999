// For my Shree DR.MDD

import java.util.*;
import java.io.*;
import java.util.stream.*;

class GrepTool {

    String grep(String pattern, List<String> flags, List<String> files) {
        StringBuilder output = new StringBuilder();
        boolean includeFileName = files.size() > 1;
        for (int fileIndex = 0; fileIndex < files.size(); fileIndex++) {
            List<String> fileLines = readFileLines(files.get(fileIndex));
            String matches = processLines(files.get(fileIndex), fileLines, pattern, flags.contains("-x"), includeFileName, flags.contains("-n"), flags.contains("-l"), flags.contains("-i"), flags.contains("-v"));
            if (!matches.isEmpty()) {
                output.append(matches).append("\n");
            }
        }
        return output.toString().trim();
    }

    private List<String> readFileLines(String filePath) {
        List<String> fileContent = new ArrayList<>();
        try {
            File file = new File(filePath);
            Scanner scanner = new Scanner(file);
            while (scanner.hasNextLine()) {
                fileContent.add(scanner.nextLine());
            }
        } catch (FileNotFoundException e) {
            e.printStackTrace();
        }
        return fileContent;
    }

    private String processLines(String filePath, List<String> lines, String pattern, boolean matchWholeLine, boolean includeFileName, boolean includeLineNum, boolean returnFileName, boolean ignoreCase, boolean invertMatch) {
        return lines.stream()
            .filter(line -> (matchWholeLine ? matchesEntireLine(line, pattern, ignoreCase) : matchesPartial(line, pattern, ignoreCase)) == !invertMatch)
            .map(line -> formatMatch(filePath, lines, line, includeFileName, includeLineNum, returnFileName))
            .distinct()
            .collect(Collectors.joining("\n"));
    }

    private boolean matchesEntireLine(String line, String pattern, boolean ignoreCase) {
        return ignoreCase ? line.equalsIgnoreCase(pattern) : line.equals(pattern);
    }

    private boolean matchesPartial(String line, String pattern, boolean ignoreCase) {
        return ignoreCase ? line.toLowerCase().contains(pattern.toLowerCase()) : line.contains(pattern);
    }

    private String formatMatch(String filePath, List<String> lines, String line, boolean includeFileName, boolean includeLineNum, boolean returnFileName) {
        if (returnFileName) return filePath;
        String filePrefix = includeFileName ? filePath + ":" : "";
        String linePrefix = includeLineNum ? (lines.indexOf(line) + 1) + ":" : "";
        return filePrefix + linePrefix + line;
    }
}
