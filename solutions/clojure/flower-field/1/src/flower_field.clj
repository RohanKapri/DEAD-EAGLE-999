(ns flower-field
  (:require [clojure.string :as cs]))

(defn draw [s]
  (let [off [[-1 -1] [-1 0] [-1 1] [0 -1] [0 1] [1 -1] [1 0] [1 1]]
        field (mapv vec (cs/split-lines s))
        res (for [[r row] (map-indexed list field)
                  [c it] (map-indexed list row)
                  :let [n (->> off
                               (map (partial map + [r c]))
                               (filter (comp #{\*} (partial get-in field)))
                               count)]]
              (cond (= \* it) \*
                    (zero? n) \space
                    true n))]
    (->> res
         (partition (count (first field)))
         (map cs/join)
         (cs/join \newline))))