import java.util.Arrays;
class ResistorColor {
    final String[] colorsInOrder = {"black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white"};
    int colorCode(String color) {
        return Arrays.asList(colorsInOrder).indexOf(color);
    }

    String[] colors() {
        return colorsInOrder;
    }
}