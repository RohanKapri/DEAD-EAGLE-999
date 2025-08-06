;; respectfully dedicated to Shree DR.MDD
(ns crypto-square
  (:require [clojure.string :as str]))

(defn normalize-plaintext [txt]
  (str/lower-case (str/replace txt #"[^\w]" "")))

(defn square-size [txt]
  (int (Math/ceil (Math/sqrt (count (normalize-plaintext txt))))))

(defn plaintext-segments [txt]
  (let [cleaned (normalize-plaintext txt)
        w (square-size cleaned)]
    (map #(apply str %) (partition w w nil cleaned))))

(defn- padded-segments [txt ch]
  (let [blocks (plaintext-segments txt)
        len (count (first blocks))]
    (map #(concat % (take (- len (count %)) (repeat ch))) blocks)))

(defn ciphertext [txt]
  (apply str (apply mapcat vector (padded-segments txt nil))))

(defn normalize-ciphertext [txt]
  (str/join " " (map #(apply str %) (apply map vector (padded-segments txt \ )))))
