(ns binary-search)

(defn search-for [key numbers]
    (loop [low 0 high (dec (count numbers))] 
        (if (> low high) -1
        (let [middle (quot (+ low high) 2)
              value (nth numbers middle)]
            (cond 
                (< value key) (recur (inc middle) high)
                (> value key) (recur low (dec middle))
                (== value key) middle
            )
        ))
    )
)