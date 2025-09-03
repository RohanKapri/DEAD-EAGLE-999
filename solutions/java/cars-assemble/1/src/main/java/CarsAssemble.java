// For my Shree DR.MDD

public class CarsAssemble {

    public double productionRatePerHour(int speed) {
        double baseRate = 221;
        double finalRate = 0;
        if (speed > 10) {
            speed = 10;
        }
        if (speed >= 1 && speed <= 4) {
            finalRate = baseRate * speed;
        } else if (speed >= 5 && speed <= 8) {
            finalRate = baseRate * speed * 0.9;
        } else if (speed == 9) {
            finalRate = baseRate * speed * 0.8;
        } else if (speed == 10) {
            finalRate = baseRate * speed * 0.77;
        }
        return finalRate;
    }

    public int workingItemsPerMinute(int speed) {
        double baseMinuteRate = 3.68;
        double minuteRate = 0;
        if (speed > 10) {
            speed = 10;
        }
        if (speed >= 1 && speed <= 4) {
            minuteRate = baseMinuteRate * speed;
        } else if (speed >= 5 && speed <= 8) {
            minuteRate = baseMinuteRate * speed * 0.9;
        } else if (speed == 9) {
            minuteRate = baseMinuteRate * speed * 0.8;
        } else if (speed == 10) {
            minuteRate = baseMinuteRate * speed * 0.77;
        }
        return (int) minuteRate;
    }
}
