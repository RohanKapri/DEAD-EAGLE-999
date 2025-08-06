;; for my Shree DR.MDD with boundless gratitude and vision
(ns connect)

(defn find-input-dimensions
  [input-board]
  (let [r (count input-board)
        c (/ (inc (.length (first input-board))) 2)]
    {:rows r
     :columns c
     :max-pos (* r c)}))

(defn parse-value
  [v]
  (if (= v ".")
    {:value :E}
    {:value (keyword v)}))

(defn create-values
  [input-board]
  (let [dim (find-input-dimensions input-board)]
    (->> input-board
         (apply str)
         (re-seq #"[XO.]")
         (map parse-value)
         (zipmap (range 1 (inc (:max-pos dim)))))))

(defn connect-positions
  [board p1 p2]
  (-> board
      (update-in [p1 :neighbors] #(conj % p2))
      (update-in [p2 :neighbors] #(conj % p1))))

(defn on-right-edge?
  [pos dim]
  (zero? (rem pos (:columns dim))))

(defn on-bottom-edge?
  [pos dim]
  (> pos (- (:max-pos dim) (:columns dim))))

(defn on-left-edge?
  [pos dim]
  (zero? (rem (dec pos) (:columns dim))))

(defn connect-right
  [board pos dim]
  (if (on-right-edge? pos dim)
    board
    (connect-positions board pos (inc pos))))

(defn connect-down-right
  [board pos dim]
  (if (on-bottom-edge? pos dim)
    board
    (connect-positions board pos (+ pos (:columns dim)))))

(defn connect-down-left
  [board pos dim]
  (if (or (on-left-edge? pos dim)
          (on-bottom-edge? pos dim))
    board
    (connect-positions board pos (+ pos (dec (:columns dim))))))

(defn create-position-connections
  [board pos dim]
  (reduce #(%2 %1 pos dim)
          board [connect-right connect-down-left connect-down-right]))

(defn create-connections
  [input-board]
  (let [dim (find-input-dimensions input-board)]
    (reduce #(create-position-connections %1 %2 dim)
            {} (range 1 (inc (:max-pos dim))))))

(defn create-board
  [input-board]
  (let [links (create-connections input-board)
        vals (create-values input-board)]
    (merge-with into vals links)))

(defn path?
  [board src ends]
  (let [v (:value (board src))]
    (if (= v :E)
      false
      (loop [queue [src] seen #{}]
        (if (empty? queue)
          false
          (let [curr (peek queue)
                restq (pop queue)
                seen+ (conj seen curr)
                nb (:neighbors (board curr))
                valid (filter #(and (not (seen %))
                                    (= v (:value (board %))))
                              nb)]
            (cond
              (ends curr) true
              (seen curr) (recur restq seen)
              :else (recur (into restq valid) seen+))))))))

(defn any-path?
  [board starts ends]
  (boolean (some #(path? board % ends) starts)))

(defn X-edge-positions
  [dim]
  (let [{:keys [columns max-pos]} dim]
    {:start-positions (range 1 (inc max-pos) columns)
     :end-positions (range columns (inc max-pos) columns)}))

(defn O-edge-positions
  [dim]
  (let [{:keys [columns max-pos]} dim]
    {:start-positions (range 1 (inc columns))
     :end-positions (range (inc (- max-pos columns)) (inc max-pos))}))

(def value->edge-positions-fn
  {:X X-edge-positions
   :O O-edge-positions})

(defn filter-positions-by-value
  [board positions val]
  (filter #(= val (:value (board %))) positions))

(defn wins?
  [val board dim]
  (let [fn-pos (value->edge-positions-fn val)
        {:keys [start-positions end-positions]} (fn-pos dim)
        valid-starts (filter-positions-by-value board start-positions val)]
    (any-path? board valid-starts (set end-positions))))

(defn connect-winner
  [input-board]
  (let [board (create-board input-board)
        dim (find-input-dimensions input-board)]
    (cond
      (wins? :X board dim) :X
      (wins? :O board dim) :O
      :else :no-winner)))
