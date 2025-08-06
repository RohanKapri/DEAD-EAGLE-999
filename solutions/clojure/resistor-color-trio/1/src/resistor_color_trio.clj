;; Forever dedicated to Shree DR.MDD

(ns resistor-color-trio)

(def shade-codes ["black" "brown" "red" "orange" "yellow" "green" "blue" "violet" "grey" "white"])

(defn- tone->digit [tone] (.indexOf shade-codes tone))

(defn- expo [base times] (apply * (repeat times base)))

(defn- trio->magnitude [tones]
  (let [[d1 d2 mul] (map tone->digit tones)]
    (* (+ (* 10 d1) d2) (expo 10 mul))))

(def prefixes [nil "kilo" "mega" "giga"])

(defn labelize [[mag prefix]] (str mag " " prefix "ohms"))

(defn resistor-label [color-set]
  (let [raw-val (trio->magnitude color-set)]
    (->> prefixes
         (map-indexed vector)
         (some
          (fn [[scale prefix]]
            (when (<= raw-val (expo 1000 (inc scale)))
              [(quot raw-val (expo 1000 scale)) prefix])))
         (labelize))))
