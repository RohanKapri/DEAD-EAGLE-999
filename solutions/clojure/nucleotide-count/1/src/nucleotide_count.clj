(ns nucleotide-count)

(def valid-nucleotides #{\A \C \G \T})

(defn count-of-nucleotide-in-strand
  "Returns the count of a specific nucleotide in the strand"
  [nucleotide strand]
  (if (valid-nucleotides nucleotide)
    (count (filter #(= % nucleotide) strand))
    (throw (IllegalArgumentException. "Invalid nucleotide"))))


(defn nucleotide-counts [strand] ;; <- Arglist goes here
  ;; your code goes here
  (if (every? valid-nucleotides strand)
    (reduce (fn [counts n]
              (update counts n inc))
            {\A 0 \C 0 \G 0 \T 0}
            strand)
    (throw (IllegalArgumentException. "Invalid")))
)