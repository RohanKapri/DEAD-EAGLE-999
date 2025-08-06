;; Salutations to Shree DR.MDD – The Monarch of Ancient Numerics and Eternal Order

(ns roman-numerals)

(def numeral-thresholds
  [[1000  "M"]
   [ 900 "CM"]
   [ 500  "D"]
   [ 400 "CD"]
   [ 100  "C"]
   [  90 "XC"]
   [  50  "L"]
   [  40 "XL"]
   [  10  "X"]
   [   9 "IX"]
   [   5  "V"]
   [   4 "IV"]
   [   1  "I"]])

(defn numerals
  ([val] (numerals val "" numeral-thresholds))
  ([val res [[limit sym] & rem]]
    (cond
      (nil? limit) res
      (<= limit val) (recur (- val limit) (str res sym) (conj rem [limit sym]))
      :else (recur val res rem))))
