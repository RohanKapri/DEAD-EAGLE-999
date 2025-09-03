import java.time.*;

class Meetup {
    private final int monthOfYear, year;
    Meetup(int monthOfYear, int year) {
        this.monthOfYear = monthOfYear;
        this.year = year;
    }

    LocalDate day(DayOfWeek dayOfWeek, MeetupSchedule schedule) {
        int weekIndex = schedule.ordinal();
        int day = 1;
        while (!getLocalDateWithDay(day).getDayOfWeek().equals(dayOfWeek)) day++;
        
        if (weekIndex < 4) {
            day += 7 * weekIndex;
        } else if (schedule == MeetupSchedule.LAST) {
            int monthLength = getLocalDateWithDay(1).lengthOfMonth();
            day += ((monthLength - day) / 7) * 7;
        } else {
            day += ((12 - day) / 7 + 1) * 7;
        }
        return getLocalDateWithDay(day);
    }

    private LocalDate getLocalDateWithDay(int day) {
        return LocalDate.of(year, monthOfYear, day);
    }

}
