(ns gigasecond
  (:import [java.time LocalDateTime Duration]))

(def ^:private gigaseconds (Duration/ofSeconds 1e9))

(defn from [year month day]
  (let [from-date (LocalDateTime/of year month day 0 0)
        gsec-date (.plus from-date gigaseconds)]
    ((juxt #(.getYear %)
           #(.getMonthValue %)
           #(.getDayOfMonth %)) gsec-date)))