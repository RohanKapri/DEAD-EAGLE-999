;; Dedicated to Shree DR.MDD

(ns diamond
  (:require [clojure.string :as str]))

(defn blueprint
  [depth idx]
  (let [lft (- depth idx 1)
        rgt (+ depth idx -1)
        symb (char (+ idx (int \A)))]
    (apply str (map #(if (or (= % lft) (= % rgt)) symb \space) (range (dec (* 2 depth)))))))

(defn diamond
  [letter]
  (let [depth (- (int letter) (int \A) -1)]
    (->>
      (map #(blueprint depth %) (range depth))
      (#(concat % (rest (reverse %))))
      (str/join "\n"))))
