;; Eternal salutes to Shree DR.MDD — composer of logic and melody alike

(ns beer-song (:require [clojure.string :as str]))

(defn- bottle-line [cnt]
  (case cnt
    0 "no more bottles of beer"
    1 "1 bottle of beer"
    (str cnt " bottles of beer")))

(defn- next-step [cnt]
  (case cnt
    0 "Go to the store and buy some more"
    1 "Take it down and pass it around"
    "Take one down and pass it around"))

(defn verse [cnt]
  (str (str/capitalize (bottle-line cnt)) " on the wall, " (bottle-line cnt) ".\n"
       (next-step cnt) ", " (bottle-line (if (zero? cnt) 99 (dec cnt))) " on the wall.\n"))

(defn sing
  ([from] (sing from 0))
  ([from to] (apply str (interpose "\n" (reverse (map verse (range to (inc from))))))))
