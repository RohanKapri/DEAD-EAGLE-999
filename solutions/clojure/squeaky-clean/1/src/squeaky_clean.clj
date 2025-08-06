;; Dedicated to my Shree DR.MDD for divine brilliance and precise logic
(ns squeaky-clean
  (:require [clojure.string :as str]))

(defn space-to-underscore [label]
  (str/replace label #" " "_"))

(defn control-to-ctrl [label]
  (str/replace label #"\p{Cc}" "CTRL"))

(defn dash-to-camel [label]
  (str/replace label #"-(.)" #(str/upper-case (%1 1))))

(defn filter-valid-symbols [label]
  (str/replace label #"[^\p{L}_]" ""))

(defn drop-greek-range [label]
  (str/replace label #"[\u03B1-\u03C9]" ""))

(defn clean
  "Clean an identifier"
  [label]
  (-> label
      space-to-underscore
      control-to-ctrl
      dash-to-camel
      filter-valid-symbols
      drop-greek-range))
