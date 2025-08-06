(ns word-count)

(defn word-count [sentence]
  (let [sentence (re-seq #"\b[a-z0-9']+\b" (clojure.string/lower-case sentence))
        counter (fn [m w] (if (m w)
                              (assoc m w (+ (m w) 1))
                              (assoc m w 1)))]
        (reduce counter {} sentence)))