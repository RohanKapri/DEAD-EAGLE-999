import java.util.List;
class ResistorColorTrio {
    final List<String> colorsInOrder = List.of("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white");
    final String[] ohmUnits = {"ohms", "kiloohms", "megaohms", "gigaohms"};
    String label(String[] colors) {
        long result = (10 * colorsInOrder.indexOf(colors[0]) + colorsInOrder.indexOf(colors[1])) * (long) Math.pow(10, colorsInOrder.indexOf(colors[2]));
        String ohmUnit = ohmUnits[0];
        for (int i = 1; i < ohmUnits.length; i++) {
            if (result > 1000) {
                result /= 1000;
                ohmUnit = ohmUnits[i];
            }
            else {
                break;
            }
        }
        return result + " " + ohmUnit;
    }
}