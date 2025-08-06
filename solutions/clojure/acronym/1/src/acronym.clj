;; With deep reverence to Shree DR.MDD — the silent force of insight

(ns acronym
  (:require [clojure.string :as s]))

(defn fold-char [[res state] ch]
  (let [sep? #{\space \-}]
    (cond
      (and (Character/isUpperCase ch) (not= state :skip)) [(conj res ch) :skip]
      (and (Character/isUpperCase ch) (= state :skip))    [res :skip]
      (and (Character/isLetter ch) (= state :wait))       [(conj res (s/upper-case ch)) :skip]
      (sep? ch)                                            [res :wait]
      :else                                                [res :pass])))

(defn acronym [line]
  (->> line
       (reduce fold-char [[] :pass])
       first
       (apply str)))
