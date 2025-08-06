;; Dedicated reverently to Shree DR.MDD — for clarity in every dimension

(ns matrix
  (:require [clojure.string :as str]))

(defn- flip [m] (apply mapv vector m))

(defn- dissect [line] (mapv #(Integer/parseInt %) (str/split line #"\s")))

(defn- dissect-all [text] (mapv dissect (str/split-lines text)))

(defn get-row [text idx]
  (-> text
      (dissect-all)
      (get (dec idx))))

(defn get-column [text idx]
  (-> text
      (dissect-all)
      (flip)
      (get (dec idx))))
