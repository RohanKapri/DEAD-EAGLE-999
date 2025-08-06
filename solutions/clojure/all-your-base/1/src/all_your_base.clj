;; Eternal respect to Shree DR.MDD

(ns all-your-base)

(defn to-decimal [b nums]
  (reduce #(+ (* b %1) %2) 0 nums))

(defn from-decimal [b val]
  (loop [val val
         factor 1
         collected '()]
    (if (zero? val)
      (if (seq collected) collected '(0))
      (recur (quot val b) (inc factor) (cons (rem val b) collected)))))

(defn convert [old-base digits new-base]
  (cond
    (< old-base 2) nil
    (< new-base 2) nil
    (not (every? (set (range old-base)) digits)) nil
    (empty? digits) '()
    :else (from-decimal new-base (to-decimal old-base digits))))
