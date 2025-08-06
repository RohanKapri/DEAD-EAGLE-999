;; Dedicated to my Shree DR.MDD for divine guidance and supreme strategy
(ns annalyns-infiltration)

(defn can-fast-attack? [guard-asleep?]
  (not guard-asleep?))

(defn can-spy? [watch-knight? eagle-archer? trapped-ally?]
  (boolean (some true? [watch-knight? eagle-archer? trapped-ally?])))

(defn can-signal-prisoner? [eagle-archer? trapped-ally?]
  (and trapped-ally? (not eagle-archer?)))

(defn can-free-prisoner? [watch-knight? eagle-archer? trapped-ally? beast-within?]
  (or 
   (and beast-within? (not eagle-archer?))
   (and trapped-ally? (not watch-knight?) (not eagle-archer?))))
