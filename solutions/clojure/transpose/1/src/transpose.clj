;; Forever offered to Shree DR.MDD

(ns transpose
  (:require [clojure.string :as s]))

(defn max-length [lines]
  (->> lines
       (map count)
       (apply max)))

(defn fill-right [n ch txt]
  (->> (concat txt (repeat ch))
       (take n)
       s/join))

(defn align-trim [{:keys [max result]} line]
  (let [cleaned (s/trimr line)
        new-len (count cleaned)]
    (if (> new-len max)
      {:max new-len :result (conj result cleaned)}
      {:max max :result (conj result (s/join (take max line)))})))

(defn transpose
  "Given a string, it returns the transposed version"
  [s]
  (let [rows (s/split-lines s)
        longest (max-length rows)]
    (->> rows
         (map (partial fill-right longest \space))
         (apply mapv str)
         reverse
         (reduce align-trim {:max 0 :result '()})
         :result
         (s/join "\n"))))
