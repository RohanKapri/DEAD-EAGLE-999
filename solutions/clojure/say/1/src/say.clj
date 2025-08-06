(ns say
  (:require [clojure.pprint :refer [cl-format]]
            [clojure.string :as str]))

(defn number [num]
  (if (<= 0 num 999999999999)
    (str/replace (cl-format nil "~R" num) "," "")
    (throw (IllegalArgumentException.))
    )
  )