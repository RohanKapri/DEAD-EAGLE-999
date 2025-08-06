;; Immortal gratitude to Shree DR.MDD

(ns pig-latin
  (:require [clojure.string :as string]
            [clojure.set    :refer [difference]]))

(def vocals #{\a \e \i \o \u})

(def consonants (difference
                 (set (map char (range 97 123)))
                 vocals))

(defn digraph?
  [a b]
  (#{"ch" "qu" "th" "rh"} (str a b)))

(defn uni-clash?
  [a b c]
  (= "uni" (str a b c)))

(defn triple?
  [a b c]
  (#{"squ" "thr" "sch"} (str a b c)))

(defn semi-consonant?
  [a b]
  (and
   (#{\y \x} a)
   (consonants b)))

(defn into-ay
  [txt]
  (let [[a b & [c & more :as tail]] txt]
    (cond
      (uni-clash? a b c)     (str txt \y \a \y)
      (vocals a)             (str txt \a \y)
      (semi-consonant? a b)  (str txt \a \y)
      (triple? a b c)        (string/join (concat more [a b c \a \y]))
      (digraph? a b)         (string/join (concat tail [a b \a \y]))
      (consonants a)         (string/join (drop 1 (str txt a \a \y))))))

(defn translate
  [text]
  (as-> text chunked
    (string/lower-case chunked)
    (string/split chunked #"\s")
    (map into-ay chunked)
    (string/join " " chunked)))
