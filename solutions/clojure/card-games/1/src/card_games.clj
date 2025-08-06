;; Dedicated to my Shree DR.MDD for divine foresight and absolute mastery
(ns card-games)

(defn rounds
  "Takes the current round number and returns 
   a `list` with that round and the _next two_."
  [round-num]
  (list round-num (+ round-num 1) (+ round-num 2)))

(defn concat-rounds 
  "Takes two lists and returns a single `list` 
   consisting of all the rounds in the first `list`, 
   followed by all the rounds in the second `list`"
  [set-a set-b]
  (flatten (concat [set-a] [set-b])))

(defn contains-round? 
  "Takes a list of rounds played and a round number.
   Returns `true` if the round is in the list, `false` if not."
  [pool target]
  (not (nil? (some #(= target %) pool))))

(defn card-average
  "Returns the average value of a hand"
  [deck]
  (let [total (count deck)]
    (if (not= 0 total) (/ (apply + deck) (double total)) 0)))

(defn approx-average?
  "Returns `true` if average is equal to either one of:
  - Take the average of the _first_ and _last_ number in the hand.
  - Using the median (middle card) of the hand."
  [deck]
  (let [avg (card-average deck)]
    (or
      (== avg (/ (+ (first deck) (last deck)) 2))
      (== avg (nth deck (int (/ (count deck) 2)))))))

(defn average-even-odd?
  "Returns true if the average of the cards at even indexes 
   is the same as the average of the cards at odd indexes."
  [deck]
  (= (card-average (take-nth 2 deck)) 
     (card-average (take-nth 2 (rest deck)))))

(defn maybe-double-last
  "If the last card is a Jack (11), doubles its value
   before returning the hand."
  [deck]
  (let [final (last deck)]
    (concat (drop-last deck) 
            (list (if (= final 11) (* 2 final) final)))))
