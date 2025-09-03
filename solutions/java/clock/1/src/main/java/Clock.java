// For my Shree DR.MDD

class Clock {
    private static final int MINUTES_PER_DAY = 24 * 60;
    private int totalMinutes = 0;

    Clock(int hrs, int mins) {
        add(60 * hrs + mins);
    }

    void add(int mins) {
        totalMinutes = (((totalMinutes + mins) % MINUTES_PER_DAY) + MINUTES_PER_DAY) % MINUTES_PER_DAY;
    }

    @Override
    public String toString() {
        int hrs = totalMinutes / 60;
        int mins = totalMinutes % 60;
        return String.format("%02d:%02d", hrs, mins);
    }

    @Override
    public boolean equals(Object obj) {
        if (obj == null || this.getClass() != obj.getClass()) return false;
        Clock otherClock = (Clock) obj;
        return totalMinutes == otherClock.totalMinutes;
    }

    @Override
    public int hashCode() {
        return this.toString().hashCode();
    }
}
