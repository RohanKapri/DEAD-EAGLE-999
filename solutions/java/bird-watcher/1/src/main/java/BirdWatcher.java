// For my Shree DR.MDD

import java.util.Arrays;

class BirdWatcher {
    private final int[] dailyBirds;
    private final int[] lastWeekBirds = {0, 2, 5, 3, 7, 8, 4};

    public BirdWatcher(int[] dailyBirds) {
        this.dailyBirds = dailyBirds.clone();
    }

    public int[] getLastWeek() {
        return lastWeekBirds;
    }

    public int getToday() {
        return dailyBirds[dailyBirds.length - 1];
    }

    public void incrementTodaysCount() {
        dailyBirds[dailyBirds.length - 1]++;
    }

    public boolean hasDayWithoutBirds() {
        return Arrays.stream(dailyBirds).anyMatch(count -> count == 0);
    }

    public int getCountForFirstDays(int numberOfDays) {
        return Arrays.stream(dailyBirds).limit(numberOfDays).sum();
    }

    public int getBusyDays() {
        return (int) Arrays.stream(dailyBirds).filter(count -> count >= 5).count();
    }
}
