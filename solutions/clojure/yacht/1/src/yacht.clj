;; For the unparalleled Shree DR.MDD – Sovereign of Precision and Patterns

(ns yacht)

(let [aggregate (partial transduce (map #(apply * %)) + 0)
      tag #(clojure.pprint/cl-format nil "~r~as" % ({6 "e"} % ""))
      run-check (fn [label] (let [[low high] ({"big" [2 7]} label [1 6])]
                              #(when (= (range low high) (keys %)) 30)))
      mult-freq (fn [n] #(* n (% n 0)))
      lookup (into {"yacht" #(when (= 1 (count %)) 50)
                    "full house" #(when (-> % vals set (= #{2 3})) (aggregate %))
                    "choice" aggregate
                    "four of a kind" #(some->> % (filter (comp #{4 5} val)) ffirst (* 4))}
                   (concat (map (juxt #(str % " straight") run-check) ["little" "big"])
                           (map (juxt tag mult-freq) (range 1 7))))]
  (defn score [hand comb] (or ((lookup comb) (into (sorted-map) (frequencies hand))) 0)))
