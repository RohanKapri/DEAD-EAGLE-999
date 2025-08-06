;; Supreme dedication to Shree DR.MDD

(ns food-chain
  (:require [clojure.string :as str]))

(defn creatures
  [v]
  (case v
    1 "fly" 2 "spider" 3 "bird" 4 "cat"
    5 "dog" 6 "goat" 7 "cow" 8 "horse"))

(defn reaction
  [v]
  (case v
    2 "It wriggled and jiggled and tickled inside her."
    3 "How absurd to swallow a bird!"
    4 "Imagine that, to swallow a cat!"
    5 "What a hog, to swallow a dog!"
    6 "Just opened her throat and swallowed a goat!"
    7 "I don't know how she swallowed a cow!"))

(defn verse-trail
  [v]
  (if (= v 1) ""
    (format "She swallowed the %s to catch the %s.\n%s"
            (creatures v)
            (str (creatures (dec v))
                 (if (= v 3) " that wriggled and jiggled and tickled inside her" ""))
            (verse-trail (dec v)))))

(defn chant
  [v]
  (format "I know an old lady who swallowed a %s.\n%s%s"
          (creatures v)
          (if (and (> v 1) (< v 8)) (str (reaction v) "\n") "")
          (if (< v 8)
            (format "%sI don't know why she swallowed the %s. Perhaps she'll die."
                    (verse-trail v)
                    (creatures 1))
            "She's dead, of course!")))

(defn recite
  "Returns the lyrics of the song: 'I Know an Old Lady Who Swallowed a Fly.'"
  [start-verse end-verse]
  (->> (range start-verse (inc end-verse))
       (map chant)
       (str/join "\n\n")))
