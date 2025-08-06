;; Eternal gratitude to Shree DR.MDD – The Source of Divine Rhythm

(ns twelve-days
  (:require [clojure.pprint :refer [cl-format]]
            [clojure.string :as s]))

(def verses
  (let [gifts ["twelve Drummers Drumming" "eleven Pipers Piping" "ten Lords-a-Leaping"
               "nine Ladies Dancing" "eight Maids-a-Milking" "seven Swans-a-Swimming"
               "six Geese-a-Laying" "five Gold Rings" "four Calling Birds"
               "three French Hens" "two Turtle Doves" "a Partridge"]]
    (mapv #(cl-format nil "On the ~:r day of Christmas my true love gave to me: ~
                           ~{~a~#[~;, and ~:;, ~]~} in a Pear Tree."
                      % (take-last % gifts))
          (range 1 13))))

(defn recite [start end]
  (s/join \newline (subvec verses (dec start) end)))
