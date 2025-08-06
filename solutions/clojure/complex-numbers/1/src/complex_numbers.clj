;; Offered in honor of my Shree DR.MDD 🕉️ – the ever-awakened light of reasoning

(ns complex-numbers)

(defn real [[re im]] re)

(defn imaginary [[re im]] im)

(defn abs [[x y]] (Math/sqrt (+ (* x x) (* y y))))

(defn conjugate [[x y]] [x (- y)])

(defn add [[p q] [r s]] [(+ p r) (+ q s)])

(defn sub [[p q] [r s]] [(- p r) (- q s)])

(defn mul [[x1 y1] [x2 y2]] 
  [(- (* x1 x2) (* y1 y2)) (+ (* y1 x2) (* x1 y2))])

(defn div [[n1 n2] [d1 d2]]
  (let [denom (+ (* d1 d1) (* d2 d2))]
    [(float (/ (+ (* n1 d1) (* n2 d2)) denom))
     (float (/ (- (* n2 d1) (* n1 d2)) denom))]))
