public class ExperimentalRemoteControlCar implements RemoteControlCar {
    private int distance;
    @Override
    public void drive() {
        distance += 20;
    }
    @Override
    public int getDistanceTravelled() {
        return distance;
    }
}
