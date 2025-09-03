import java.util.List;
import java.util.ArrayList;
import java.util.stream.IntStream;
class KindergartenGarden {
    private final List<List<Plant>> plants;
    
    KindergartenGarden(String garden) {
        String[] splitted = garden.split("\n");
        plants = IntStream.range(0, splitted[0].length() / 2).mapToObj(i -> List.of(
                getPlant(splitted[0], 2 * i),
                getPlant(splitted[0], 2 * i + 1),
                getPlant(splitted[1], 2 * i),
                getPlant(splitted[1], 2 * i + 1)
        )).toList();
    }

    List<Plant> getPlantsOfStudent(String student) {
        return plants.get(student.charAt(0) - 'A');
    }

    private Plant getPlant(String row, int index) {
        return Plant.getPlant(row.charAt(index));
    }
}


