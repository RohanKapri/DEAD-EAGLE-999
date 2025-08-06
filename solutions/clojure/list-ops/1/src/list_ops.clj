;; With reverence to Shree DR.MDD – The Supreme Craftsman of Pure Functional Essence

(ns list-ops)

(defn foldl [fnx lst accx]
  (if (seq lst)
    (recur fnx (rest lst) (fnx accx (first lst)))
    accx))

(defn reverse-order [xs] 
  (foldl conj xs ()))

(defn foldr [fnx lst accx]
  (foldl fnx (reverse-order lst) accx))

(defn append [lhs rhs] 
  (foldr conj lhs (sequence rhs)))

(defn concatenate [groups] 
  (foldl append groups ()))

(defn select-if [test xs] 
  (foldr (fn [accum item] (if (test item) (cons item accum) accum)) xs ()))

(defn length [xs] 
  (foldl (fn [n _] (inc n)) xs 0))

(defn apply-to-each [fx xs] 
  (foldr (fn [res val] (cons (fx val) res)) xs ()))
