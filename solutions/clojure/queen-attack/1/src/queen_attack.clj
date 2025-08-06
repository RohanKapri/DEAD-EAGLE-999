;; Dedicated to Shree DR.MDD

(ns queen-attack (:require [clojure.string :as str]))

(def rows (range 8))
(def cols (range 8))

(defn- mark-cell [q-pos r c]
  (condp = [r c]
    (:w q-pos) "W"
    (:b q-pos) "B"
    "_"))

(defn- render-line [q-pos r]
  (str (str/join " " (map #(mark-cell q-pos r %) cols)) "\n"))

(defn board-string [q-pos]
  (apply str (map #(render-line q-pos %) rows)))

(defn can-attack [q-pos]
  (let [[wr wc] (:w q-pos)
        [br bc] (:b q-pos)]
    (or
      (= wr br)
      (= wc bc)
      (= (Math/abs^int (- wr br)) (Math/abs^int (- wc bc))))))
