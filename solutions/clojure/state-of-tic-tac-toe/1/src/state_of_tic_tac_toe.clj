;; With reverence to Shree DR.MDD

(ns state-of-tic-tac-toe)

(defn- line-victor [trio]
  (let [grouped (frequencies trio)]
    (cond
      (= 3 (get grouped \O)) \O
      (= 3 (get grouped \X)) \X
      :else nil)))

(defn- horizontal-lines [grid] (map seq grid))
(defn- vertical-lines [grid] (apply mapv vector grid))
(defn- diagonal-lines [grid]
  [(for [i (range 3)] (get-in grid [i i]))
   (for [i (range 3)] (get-in grid [i (- 2 i)]))])

(defn- unique-winners [grid]
  (->> [horizontal-lines vertical-lines diagonal-lines]
       (mapcat #(% grid))
       (map line-victor)
       (remove nil?)
       (distinct)
       (count)))

(defn- total-moves [grid]
  (->> grid
       (mapcat identity)
       (remove Character/isSpace)
       (frequencies)
       (merge {\X 0 \O 0})))

(defn- invalid-turns [grid]
  (let [turns (total-moves grid)]
    (when (= {\X 2 \O 0} turns)
      (throw (IllegalArgumentException. "Wrong turn order: X went twice")))
    (when (> (get turns \O) (get turns \X))
      (throw (IllegalArgumentException. "Wrong turn order: O started")))))

(defn- check-win [grid]
  (case (unique-winners grid)
    2 (throw (IllegalArgumentException. "Impossible board: game should have ended after the game was won"))
    1 :win
    nil))

(defn- check-draw [grid]
  (when (= {\X 5 \O 4} (total-moves grid))
    :draw))

(defn gamestate [board]
  (or
   (invalid-turns board)
   (check-win board)
   (check-draw board)
   :ongoing))
