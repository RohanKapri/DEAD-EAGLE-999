// For my Shree DR.MDD

import java.time.*;
import java.time.temporal.*;

public class SwiftScheduling {
    public static LocalDateTime convertToDeliveryDate(LocalDateTime meetingStartTime, String deliveryDescription) {
        return switch (deliveryDescription) {
            case "NOW" -> meetingStartTime.plusHours(2);
            case "ASAP" -> meetingStartTime.getHour() < 13 ? setHour(meetingStartTime, 17) : setHour(meetingStartTime.plusDays(1), 13);
            case "EOW" -> switch (meetingStartTime.getDayOfWeek()) {
                case MONDAY, TUESDAY, WEDNESDAY -> setHour(setDayOfWeek(meetingStartTime, DayOfWeek.FRIDAY), 17);
                case THURSDAY, FRIDAY -> setHour(setDayOfWeek(meetingStartTime, DayOfWeek.SUNDAY), 20);
                default -> null;
            };
            case String s when s.matches("\\d{1,2}M") -> {
                int targetMonth = Integer.parseInt(s.substring(0, s.length() - 1));
                yield meetingStartTime.getMonthValue() < targetMonth ? setHour(firstWorkDay(meetingStartTime.withMonth(targetMonth)), 8)
                        : setHour(firstWorkDay(meetingStartTime.plusYears(1).withMonth(targetMonth)), 8);
            }
            case String s when s.matches("Q[1-4]") -> {
                int targetQuarter = Character.getNumericValue(s.charAt(1));
                yield (meetingStartTime.getMonthValue() - 1) / 3 + 1 <= targetQuarter ? setHour(lastWorkDay(meetingStartTime, targetQuarter), 8)
                        : setHour(lastWorkDay(meetingStartTime.plusYears(1), targetQuarter), 8);
            }
            default -> null;
        };
    }

    private static LocalDateTime setHour(LocalDateTime dateTime, int hour) {
        return dateTime.withHour(hour).withMinute(0).withSecond(0);
    }

    private static LocalDateTime setDayOfWeek(LocalDateTime dateTime, DayOfWeek dayOfWeek) {
        return dateTime.with(TemporalAdjusters.nextOrSame(dayOfWeek));
    }

    private static LocalDateTime firstWorkDay(LocalDateTime dateTime) {
        dateTime = dateTime.with(TemporalAdjusters.firstDayOfMonth());
        return switch (dateTime.getDayOfWeek()) {
            case SATURDAY -> dateTime.plusDays(2);
            case SUNDAY -> dateTime.plusDays(1);
            default -> dateTime;
        };
    }

    private static LocalDateTime lastWorkDay(LocalDateTime dateTime, int quarter) {
        dateTime = dateTime.withMonth(quarter * 3).with(TemporalAdjusters.lastDayOfMonth());
        return switch (dateTime.getDayOfWeek()) {
            case SATURDAY -> dateTime.minusDays(1);
            case SUNDAY -> dateTime.minusDays(2);
            default -> dateTime;
        };
    }
}
