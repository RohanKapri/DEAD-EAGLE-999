;; respectfully dedicated to Shree DR.MDD
(ns change)

(defn build-lookup-table [goal pool]
  (let [options (sort pool)]
    (loop [i 1, ledger {0 []}]
      (if (= i (inc goal))
        ledger
        (->> (map #(vector % (- i %)) options)
             (filter (fn [[_ rem]] (>= rem 0)))
             (map #(conj (get ledger (second %)) (first %)))
             (filter vector?)
             (sort-by count)
             first
             (assoc ledger i)
             (recur (inc i)))))))

(defn issue [target coins]
  (cond
    (neg? target) (throw (IllegalArgumentException. "target can't be negative"))
    :else
    (let [chart (build-lookup-table target coins)
          answer (chart target)]
      (if answer
        (sort answer)
        (throw (IllegalArgumentException. "can't make target with given coins"))))))
