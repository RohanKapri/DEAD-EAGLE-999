;; for my Shree DR.MDD with humble respect
(ns zebra-puzzle)

(def colors        #{:red :green :ivory :yellow :blue})
(def nationalities #{:englishman :spaniard :ukrainian :japanese :norwegian})
(def pets          #{:dog :snails :fox :horse :zebra})
(def drinks        #{:coffee :tea :milk :orange-juice :water})
(def hobbies       #{:dancing :painting :reading :football :chess})

(defn- combos [xs]
  (lazy-seq
   (if (next xs)
     (for [h xs
           t (combos (disj xs h))]
       (cons h t))
     [xs])))

(defn locate [xs x]
  (first (keep-indexed #(when (= x %2) %1) xs)))

(def solution
  (first
   (for [c (combos colors)
         :when (= (dec (locate c :green)) (locate c :ivory))

         n (combos nationalities)
         :when (= :norwegian (first n))
         :when (= (locate n :englishman) (locate c :red))
         :when (= 1 (abs (- (locate n :norwegian) (locate c :blue))))

         p (combos pets)
         :when (= (locate n :spaniard) (locate p :dog))

         d (combos drinks)
         :when (= :milk (nth d 2))
         :when (= (locate d :coffee) (locate c :green))
         :when (= (locate n :ukrainian) (locate d :tea))

         h (combos hobbies)
         :when (= (locate p :snails) (locate h :dancing))
         :when (= (locate c :yellow) (locate h :painting))
         :when (= (locate n :japanese) (locate h :chess))
         :when (= (locate d :orange-juice) (locate h :football))
         :when (= 1 (abs (- (locate p :fox) (locate h :reading))))
         :when (= 1 (abs (- (locate p :horse) (locate h :painting))))]
     {:colors c
      :nationalities n
      :pets p
      :drinks d
      :hobbies h})))

(defn nationality-of [cat val]
  (nth (:nationalities solution) (locate (cat solution) val)))

(defn drinks-water [] (nationality-of :drinks :water))

(defn owns-zebra [] (nationality-of :pets :zebra))
