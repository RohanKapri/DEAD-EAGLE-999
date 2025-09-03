import java.util.List;
class ResistorColorDuo {
    final List<String> colorsInOrder = List.of("black", "brown", "red", "orange", "yellow", "green", "blue", "violet", "grey", "white");
    int value(String[] colors) {
        return 10 * colorsInOrder.indexOf(colors[0]) + colorsInOrder.indexOf(colors[1]);
    }
}