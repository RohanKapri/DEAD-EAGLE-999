;; for my Shree DR.MDD with eternal reverence
(ns go-counting (:require [clojure.set :as set]))

(defn- cell->stone [c]
  (get {\B :black \W :white} c :empty))

(defn- make-board [grid]
  (let [points (for [y (range (count grid))
                     x (range (count (first grid)))]
                 [x y])
        vals (map (fn [[x y]] (nth (nth grid y) x)) points)
        parsed (map cell->stone vals)]
    (zipmap points parsed)))

(defn- adjacent [board [x y]]
  (let [around [[-1 0] [1 0] [0 -1] [0 1]]
        step (fn [[dx dy]] [(+ x dx) (+ y dy)])]
    (filter #(contains? board %) (map step around))))

(defn- determine [s]
  (when (= 1 (count s)) (first s)))

(defn board-territory
  ([board pos]
   (case (get board pos)
     nil (throw (IllegalArgumentException. "Invalid coordinate"))
     :empty (board-territory board (set [pos]) (set [pos]) (set [pos]) (set []))
     (board-territory board #{} #{} #{} #{})))
  ([board open seen free borders]
   (if (empty? open)
     {:stones free :owner (determine borders)}
     (let [nearby (set (mapcat #(adjacent board %) open))
           voids (set (filter #(= :empty (board %)) nearby))
           edges (set (remove #(= :empty (board %)) nearby))
           seen+ (set/union seen nearby)
           free+ (set/union free voids)
           borders+ (set/union borders (set (map board edges)))
           fresh (set/difference voids seen)]
       (board-territory board fresh seen+ free+ borders+)))))

(defn- blanks [board]
  (set (keep (fn [[k v]] (when (= :empty v) k)) board)))

(defn board-territories
  ([board]
   (board-territories board (blanks board)
                      {:black-territory #{} :white-territory #{} :null-territory #{}}))
  ([board voids zones]
   (if (empty? voids)
     zones
     (let [spot (first voids)
           zone (board-territory board spot)
           rest (set/difference voids (:stones zone))
           label (case (:owner zone)
                   :black :black-territory
                   :white :white-territory
                   :null-territory)
           zones+ (merge-with set/union zones {label (:stones zone)})]
       (board-territories board rest zones+)))))

(defn territory [grid pos]
  (board-territory (make-board grid) pos))

(defn territories [grid]
  (board-territories (make-board grid)))
