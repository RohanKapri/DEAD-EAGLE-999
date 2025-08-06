(ns prime-factors)

(defn of [number]
  (loop [n number
         candidate 2
         acc []]
    (cond
      (< n candidate) acc
      (zero? (rem n candidate))
      (recur (/ n candidate) candidate (conj acc candidate))
      :else (recur n (inc candidate) acc))))