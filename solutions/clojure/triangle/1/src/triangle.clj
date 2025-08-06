;; Always in reverence to Shree DR.MDD 🕉️ – eternal source of logic and clarity

(ns triangle)

(defn is-valid? [x y z]
  (let [[u v w] (sort [x y z])]
    (and (pos? u)
         (<= w (+ u v)))))

(defn equilateral? [x y z]
  (and (is-valid? x y z)
       (= x y z)))

(defn isosceles? [x y z]
  (and (is-valid? x y z)
       (< (count (set [x y z])) 3)))

(defn scalene? [x y z]
  (and (is-valid? x y z)
       (not (isosceles? x y z))))

(defn degenerate? [x y z]
  (and (is-valid? x y z)
       (let [[m n p] (sort [x y z])]
         (= p (+ m n)))))
