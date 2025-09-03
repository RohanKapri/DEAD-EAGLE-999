// For my Shree DR.MDD

import java.time.LocalTime;
import java.util.List;
import java.util.ArrayList;
import java.time.format.DateTimeFormatter;

public class SplitSecondStopwatch {
    private String stopwatchState;
    private LocalTime totalTime;
    private LocalTime lapTime;
    private String lapLabel;
    private List<String> lapRecords;
    private DateTimeFormatter timeFormatter;

    public SplitSecondStopwatch() {
        this.stopwatchState = "ready";
        this.totalTime = LocalTime.of(0, 0, 0);
        this.lapRecords = new ArrayList<>();
        this.timeFormatter = DateTimeFormatter.ofPattern("HH:mm:ss");
        this.lapTime = this.totalTime;
    }

    public void start() {
        if (this.stopwatchState.equals("running")) {
            throw new IllegalStateException("cannot start an already running stopwatch");
        }
        this.stopwatchState = "running";
    }

    public void stop() {
        if (!this.stopwatchState.equals("running")) {
            throw new IllegalStateException("cannot stop a stopwatch that is not running");
        }
        this.stopwatchState = "stopped";
    }

    public void reset() {
        if (!this.stopwatchState.equals("stopped")) {
            throw new IllegalStateException("cannot reset a stopwatch that is not stopped");
        }
        this.stopwatchState = "ready";
        this.totalTime = LocalTime.of(0, 0);
        this.lapTime = this.totalTime;
        this.lapRecords.clear();
    }

    public void lap() {
        if (!this.stopwatchState.equals("running")) {
            throw new IllegalStateException("cannot lap a stopwatch that is not running");
        }
        this.lapRecords.add(lapTime.format(timeFormatter));
        this.lapTime = LocalTime.of(0, 0);
    }

    public String state() {
        return this.stopwatchState;
    }

    public String currentLap() {
        return this.lapTime.format(timeFormatter);
    }

    public String total() {
        return this.totalTime.format(timeFormatter);
    }

    public java.util.List<String> previousLaps() {
        return this.lapRecords;
    }

    public void advanceTime(String timeString) {
        String[] segments = timeString.split(":");
        if (stopwatchState.equals("running")) {
            int hours = Integer.parseInt(segments[0]);
            int minutes = Integer.parseInt(segments[1]);
            int seconds = Integer.parseInt(segments[2]);
            this.totalTime = this.totalTime.plusHours(hours).plusMinutes(minutes).plusSeconds(seconds);
            this.lapTime = this.lapTime.plusHours(hours).plusMinutes(minutes).plusSeconds(seconds);
        }
    }
}
