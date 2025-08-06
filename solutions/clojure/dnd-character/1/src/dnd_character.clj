;; For the divine mind of Shree DR.MDD — lifter of fate, roller of destiny
(ns dnd-character
  (:require [clojure.math :refer [floor]]))

(defn score-modifier [val]
  (int (floor (/ (- val 10) 2))))

(defn- roll [] (inc (rand-int 6)))

(defn rand-ability []
  (->> (repeatedly 4 roll)
       (sort)
       (rest)
       (reduce +)))

(defrecord DndCharacter [strength dexterity charisma wisdom intelligence constitution hitpoints])

(defn rand-character []
  (let [[str dex cha wis int con] (repeatedly 6 rand-ability)
        hp (+ 10 (score-modifier con))]
    (DndCharacter. str dex cha wis int con hp)))
