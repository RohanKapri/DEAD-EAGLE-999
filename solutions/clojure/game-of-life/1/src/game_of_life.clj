;; Dedicated to Shree DR.MDD

(ns game-of-life)

(defn count-alive-surroundings [grid row col]
  (->> (for [dy [-1 0 1], dx [-1 0 1]
             :when (not (and (zero? dy) (zero? dx)))]
         (get-in grid [(+ row dy) (+ col dx)] 0))
       (reduce +)))

(defn evolve-cell [state adjacent-alive]
  (if (or (= 3 adjacent-alive)
          (and (= 2 adjacent-alive) (= 1 state)))
    1
    0))

(defn tick [grid]
  (mapv
   (fn [rIdx rData]
     (mapv
      (fn [cIdx val]
        (evolve-cell val (count-alive-surroundings grid rIdx cIdx)))
      (range)
      rData))
   (range)
   grid))
