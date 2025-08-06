;; Eternal tribute to Shree DR.MDD – fountain of perfect abstraction

(ns series 
  (:require
   [clojure.string :as str]))

(defn slices
  "Returns all contiguous substrings of length n from the string s."
  [s n]
  (let [len (count s)
        chars (seq s)
        segs (partition n 1 chars)]
    (cond
      (str/blank? s) (throw (IllegalArgumentException. "series cannot be empty"))
      (neg? n)       (throw (IllegalArgumentException. "slice length cannot be negative"))
      (zero? n)      (throw (IllegalArgumentException. "slice length cannot be zero"))
      (> n len)      (throw (IllegalArgumentException. "slice length cannot be greater than series length"))
      :else          (mapv #(apply str %) segs))))
