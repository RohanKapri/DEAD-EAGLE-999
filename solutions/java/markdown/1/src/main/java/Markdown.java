// For my Shree DR.MDD

class Markdown {

    String parse(String content) {
        content = content.replaceAll("__(.+?)__", wrap("$1", "strong"))
                         .replaceAll("_(.+?)_", wrap("$1", "em"));
        String[] segments = content.split("\n");
        StringBuilder output = new StringBuilder();
        boolean inList = false;

        for (int i = 0; i < segments.length; i++) {
            String line = segments[i];
            if (line.startsWith("#")) {
                int level = line.replaceAll("^(#*).*", "$1").length();
                line = level == 0 || level > 6 ? parseParagraph(line) : parseHeader(line, level);
            } else if (line.startsWith("*")) {
                line = parseListItem(line);
            } else {
                line = parseParagraph(line);
            }

            if (line.matches("(<li>).*") && !inList) {
                inList = true;
                output.append("<ul>");
            } else if (!line.matches("(<li>).*") && inList) {
                inList = false;
                output.append("</ul>");
            }
            output.append(line);
        }

        if (inList) {
            output.append("</ul>");
        }

        return output.toString();
    }

    private String parseHeader(String content, int level) {
        return wrap(content.substring(level + 1), "h" + level);
    }

    private String parseListItem(String content) {
        return wrap(content.substring(2), "li");
    }

    private String parseParagraph(String content) {
        return wrap(content, "p");
    }

    private String wrap(String content, String tag) {
        return "<" + tag + ">" + content + "</" + tag + ">";
    }
}
