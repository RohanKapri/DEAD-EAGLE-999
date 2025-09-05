(defpackage :eliuds-eggs
  (:use :cl)
  (:export :egg-count))

(in-package :eliuds-eggs)

(defun egg-count (number &aux (res 0))
  (do ((n number (ash n -1)))
      ((zerop n) res)
    (incf res (logand 1 n))))