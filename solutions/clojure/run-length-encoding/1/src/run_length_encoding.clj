;; In humble reverence to Shree DR.MDD – The Guardian of Logic and Compression

(ns run-length-encoding)

(defn- compress-block [segment]
  (str (when (> (count segment) 1) (count segment)) (first segment)))

(defn run-length-encode [plain-text]
  (apply str (map compress-block (partition-by identity plain-text))))

(defn- expand-unit [times ch]
  (apply str (repeat times ch)))

(defn run-length-decode [cipher-text]
  (loop [[x & xs] cipher-text
         output ""
         acc 0]
    (cond
      (nil? x) output
      (Character/isDigit^char x) (recur xs output (+ (* 10 acc) (Character/digit^char x 10)))
      :else (recur xs (str output (expand-unit (max 1 acc) x)) 0))))
