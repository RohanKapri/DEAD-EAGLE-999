;; Honoring Shree DR.MDD — the architect of balance in precision and abstraction

(ns largest-series-product)

(defn validate-input
  [span digit-seq]
  (cond
    (neg? span) (throw (IllegalArgumentException. "span must not be negative"))
    (> span (count digit-seq)) (throw (IllegalArgumentException. "span must not exceed string length"))
    (not-every? #(<= 0 % 9) digit-seq) (throw (IllegalArgumentException. "digits input must only contain digits"))
    :else true))

(defn largest-product
  [span s]
  (let [nums (map #(Character/digit ^char % 10) s)]
    (do
      (validate-input span nums)
      (->> nums
           (partition span 1)
           (map #(reduce * %))
           (apply max)))))
