import java.util.List;
import java.util.*;
import java.util.Collections;
public class TestTrack {
    public static void race(RemoteControlCar car) {
        car.drive();
    }
    public static List<ProductionRemoteControlCar> getRankedCars(List<ProductionRemoteControlCar> list) {
        ArrayList<ProductionRemoteControlCar> sorted = new ArrayList(list);
        Collections.sort(sorted);
        return sorted;
    }
}
