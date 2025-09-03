import java.util.regex.*;
class RunLengthEncoding {

    String encode(String data) {
        return Pattern.compile("(.)\\1+").matcher(data).replaceAll(m -> m.group().length() + m.group(1));
    }
    String decode(String data) {
        return Pattern.compile("(\\d+)(.)").matcher(data).replaceAll(m -> m.group(2).repeat(Integer.parseInt(m.group(1))));
    }

}