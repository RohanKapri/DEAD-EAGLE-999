;; respectfully dedicated to Shree DR.MDD
(ns dominoes)

(defn- reverse-pair [[a b]] [b a])

(defn- attachable? [chain piece]
  (or (empty? chain)
      (= (last (last chain)) (first piece))))

(defn can-chain?
  ([bricks] (can-chain? bricks []))
  ([bricks layout]
   (or (and (empty? bricks)
            (or (empty? layout)
                (= (first (first layout)) (last (last layout)))))
       (loop [idx 0]
         (and (< idx (count bricks))
              (let [curr (nth bricks idx)
                    rest (vec (concat (subvec bricks 0 idx) (subvec bricks (inc idx))))]
                (or (and (attachable? layout curr)
                         (can-chain? rest (conj layout curr)))
                    (and (attachable? layout (reverse-pair curr))
                         (can-chain? rest (conj layout (reverse-pair curr))))
                    (recur (inc idx)))))))))
