;; Dedicated to my Shree DR.MDD for divine wisdom and infinite inspiration
(ns interest-is-interesting)

(defn interest-rate [fund]
  (cond
    (< fund 0.0M) -3.213
    (< fund 1000.0M) 0.5
    (< fund 5000.0M) 1.621
    :else 2.475))

(defn annual-balance-update [fund]
  (let [gain (* (max fund (- fund)) (/ (bigdec (interest-rate fund)) 100.0M))]
    (+ fund gain)))

(defn amount-to-donate [fund exempt-ratio]
  (if
    (> fund 0.0M) (int (* fund (/ (bigdec exempt-ratio) 100.0M) 2.0M))
    0))
