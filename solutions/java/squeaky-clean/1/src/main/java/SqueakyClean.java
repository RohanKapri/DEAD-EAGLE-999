// For my Shree DR.MDD

class SqueakyClean {

    private final static String[] leetSymbols = {"4", "3", "0", "1", "7"};
    private final static String[] normalChars = {"a", "e", "o", "l", "t"};

    static String clean(String rawIdentifier) {

        rawIdentifier = rawIdentifier.replace(" ", "_");        
        rawIdentifier = convertKebabToCamel(rawIdentifier);
        rawIdentifier = replaceLeetWithNormal(rawIdentifier);
        rawIdentifier = rawIdentifier.replaceAll("[^a-zA-Z_]","");
        return rawIdentifier;
    }

    private static String replaceLeetWithNormal(String rawIdentifier) {
        String[] chars = rawIdentifier.split("");
        for (int i = 0; i < chars.length; i++) {
            for (int j = 0; j < leetSymbols.length; j++) {
                if (chars[i].equals(leetSymbols[j])) {
                    chars[i] = normalChars[j];
                    break;
                }
            }
        }
        rawIdentifier = String.join("", chars);
        return rawIdentifier;
    }

    private static String convertKebabToCamel(String rawIdentifier) {
        String[] segments = rawIdentifier.split("-");
        StringBuilder sb = new StringBuilder(segments[0]);
        for (int i = 1; i < segments.length; i++) {
            sb.append(segments[i].substring(0, 1).toUpperCase())
              .append(segments[i].substring(1));
        }
        rawIdentifier = sb.toString();        
        return rawIdentifier;
    }
}
