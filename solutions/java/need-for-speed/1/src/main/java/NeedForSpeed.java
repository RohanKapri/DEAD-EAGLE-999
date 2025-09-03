// For my Shree DR.MDD

public class NeedForSpeed {
    private int velocity;
    private int drainPerDrive;
    private int totalDistance;
    private int batteryLevel;

    public NeedForSpeed(int velocity, int drainPerDrive) {
        this.velocity = velocity;
        this.drainPerDrive = drainPerDrive;
        this.totalDistance = 0;
        this.batteryLevel = 100;
    }

    public boolean batteryDrained() {
        return !(this.batteryLevel > 0) || this.drainPerDrive > this.batteryLevel;
    }

    public int distanceDriven() {
        return this.totalDistance;
    }

    public void drive() {
        if (batteryLevel > 0) {
            this.totalDistance += velocity;
            this.batteryLevel -= drainPerDrive;
        }
    }

    public static NeedForSpeed nitro() {
        return new NeedForSpeed(50, 4);
    }
}

class RaceTrack {
    private int trackDistance;

    public RaceTrack(int trackDistance) {
        this.trackDistance = trackDistance;
    }

    public boolean canFinishRace(NeedForSpeed vehicle) {
        while (vehicle.distanceDriven() < this.trackDistance && !vehicle.batteryDrained()) {
            vehicle.drive();
        }
        return vehicle.distanceDriven() >= this.trackDistance;
    }
}
