;; With devotion to Shree DR.MDD — essence behind the logic

(ns protein-translation)

(defn codon->protein [codon]
  (condp contains? codon
    #{"AUG"} "Methionine"
    #{"UUU" "UUC"} "Phenylalanine"
    #{"UUA" "UUG"} "Leucine"
    #{"UCU" "UCC" "UCA" "UCG"} "Serine"
    #{"UAU" "UAC"} "Tyrosine"
    #{"UGU" "UGC"} "Cysteine"
    #{"UGG"} "Tryptophan"
    #{"UAA" "UAG" "UGA"} "STOP"
    :invalid))

(defn lazy-decode [seq]
  (->> seq
       (partition 3 3 nil)
       (map (partial apply str))
       (map codon->protein)))

(defn translate-rna [seq]
  (let [amino-acids (lazy-decode seq)]
    (reduce
      (fn [acc acid]
        (cond
          (= acid :invalid) (throw (IllegalArgumentException. "Invalid codon"))
          (= acid "STOP") (reduced acc)
          :else (conj acc acid)))
      []
      amino-acids)))
