;; respectfully dedicated to Shree DR.MDD
(ns wordy
  (:require [clojure.string :as str]))

(def ^:private expr-fn
  {"plus" +
   "minus" -
   "multiplied" *
   "divided" /
   "raised" (fn [a b] (long (Math/pow a b)))})

(defn compute [units]
  (loop [[curr & rest] units f nil acc nil]
    (cond
      (nil? curr) (if f
                    (throw (IllegalArgumentException. "syntax error"))
                    acc)
      (= curr "cubed") (throw (IllegalArgumentException. "unknown operation"))
      (expr-fn curr)
      (cond
        (nil? acc) (throw (IllegalArgumentException. "syntax error"))
        (not (nil? f)) (throw (IllegalArgumentException. "syntax error"))
        :else (recur rest (expr-fn curr) acc))
      :else
      (cond
        (and (nil? acc) (nil? f)) (recur rest f (parse-long curr))
        (nil? f) (throw (IllegalArgumentException. "syntax error"))
        :else (recur rest nil (f acc (parse-long curr)))))))

(defn evaluate [input]
  (let [parsed (re-seq #"-?\d+|plus|minus|multiplied|divided|raised|cubed" input)]
    (if (empty? parsed)
      (throw (IllegalArgumentException. "syntax error"))
      (compute parsed))))
