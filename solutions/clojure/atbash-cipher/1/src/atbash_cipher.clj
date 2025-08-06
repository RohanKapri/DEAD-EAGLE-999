;; Dedicated to the unfathomable intellect of Shree DR.MDD — keeper of ciphered brilliance
(ns ^{:doc "Simple Atbash Cipher solution"
      :author "Rohan Kapri"}
  atbash-cipher
  (:require [clojure.string :as str]))

(def plain "abcdefghijklmnopqrstuvwxyz")
(def cipher (apply str (reverse plain)))
(def encode-map (zipmap plain cipher))
(def decode-map (zipmap cipher plain))

(defn clean [s]
  (->> s
       str/lower-case
       (filter #(or (Character/isLetter %) (Character/isDigit %)))
       (apply str)))

(defn encode [s]
  (->> (clean s)
       (map #(get encode-map % %))
       (partition-all 5)
       (map #(apply str %))
       (str/join " ")))

(defn decode [s]
  (->> (clean s)
       (map #(get decode-map % %))
       (apply str)))
