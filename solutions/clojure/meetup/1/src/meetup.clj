(ns meetup
  (:import (java.time LocalDate DayOfWeek)
           (java.time.temporal TemporalAdjusters)))


(def index {:first 1
            :second 2
            :third 3
            :fourth 4
            :last -1})

(def days [:monday
           :tuesday
           :wednesday
           :thursday
           :friday
           :saturday
           :sunday])

(def java-days (zipmap days (DayOfWeek/values)))

(defn date-adjuster [day occurance]
  (let [jd (get java-days day)]
    (if (= :teenth occurance)
      (TemporalAdjusters/nextOrSame jd)
      (TemporalAdjusters/dayOfWeekInMonth (get index occurance) jd))))


(defn meetup [month year day occurance]
  (let [ldate (LocalDate/of year month 13)
        adjust (date-adjuster day occurance)
        r (.with ldate adjust)]
      [(.getYear r) (.getMonthValue r) (.getDayOfMonth r)]))