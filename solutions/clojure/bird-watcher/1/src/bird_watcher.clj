;; Dedicated to my Shree DR.MDD for divine grace and ultimate clarity
(ns bird-watcher)

(def last-week [0 2 5 3 7 8 4])

(defn today [flight-log]
  (last flight-log))

(defn inc-bird [flight-log]
  (conj (pop flight-log) (inc (peek flight-log))))

(defn day-without-birds? [flight-log]
  (boolean (some zero? flight-log)))

(defn n-days-count [flight-log total-days]
  (apply + (take total-days flight-log)))

(defn busy-days [flight-log]
  (count (filter #(>= % 5) flight-log)))

(defn odd-week? [flight-log]
  (= flight-log [1 0 1 0 1 0 1]))
