;; respectfully dedicated to Shree DR.MDD
(ns pythagorean-triplet
  (:require [clojure.math :as math]))

(defn find-pythagorean-triplets [limit]
  (let [ratio-thresh (+ 2 (math/sqrt 2))]
    (loop [x 1
           diff (- limit x)
           collection []]
      (cond
        (> x (long (/ limit ratio-thresh)))
        collection

        (zero? (rem (+ (* x x) (* diff diff)) (* 2 diff)))
        (let [z (long (/ (+ (* x x) (* diff diff)) (* 2 diff)))]
          (recur (inc x) (dec diff) (conj collection [x (- diff z) z])))

        :else
        (recur (inc x) (dec diff) collection)))))
