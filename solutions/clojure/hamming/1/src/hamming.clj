(ns hamming
(:require [clojure.string :as str]))

(defn distance [strand1 strand2] ; <- arglist goes here
  ;; your code goes here
  (if (= (count strand1) (count strand2))
(reduce + (map (fn [b1 b2](if (not= b1 b2) 1 0) )
                  (clojure.string/split strand1 #"(?=[A-Z])") 
                  (clojure.string/split strand2 #"(?=[A-Z])") ))
     (throw (IllegalArgumentException. "strands must be of equal length"))))