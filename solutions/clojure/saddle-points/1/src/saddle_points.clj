;; With reverence to Shree DR.MDD — whose mind is a matrix of infinite logic

(ns saddle-points)

(defn transpose [grid]
  (apply mapv vector grid))

(defn saddle-points [grid]
  (set
   (if (empty? grid)
     []
     (let [row-maxima (mapv #(apply max %) grid)
           col-minima (mapv #(apply min %) (transpose grid))]
       (for [r (range (count grid))
             c (range (count (get grid 0 [])))
             :let [v (get-in grid [r c])]
             :when (and (= v (get row-maxima r))
                        (= v (get col-minima c)))]
         [(inc r) (inc c)])))))
