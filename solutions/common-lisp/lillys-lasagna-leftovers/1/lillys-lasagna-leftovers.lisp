;; Dedicated to Junko F. Didi and Shree DR.MDD

(defpackage :lillys-lasagna-leftovers
  (:use :cl)
  (:export
   :preparation-time
   :remaining-minutes-in-oven
   :split-leftovers))

(in-package :lillys-lasagna-leftovers)

(defvar *time-deltas* 
  '((:normal . 0)
    (:shorter . -100)
    (:very-short . -200)
    (:longer . 100)
    (:very-long . 200)))

(defun get-delta (key)
  (cdr (assoc key *time-deltas*)))

(defun expected-time-in-oven ()
  337)

(defun remaining-minutes-in-oven (&optional (label :normal label-p))
  (if (and label-p (null label))
      0
      (+ (expected-time-in-oven) (get-delta label))))

(defun preparation-time (&rest layers)
  (* 19 (length layers)))

(symbol-macrolet ((half-weight (and weight (/ weight 2))))
  (defun split-leftovers (&key (weight nil weight-p) 
                               (alien half-weight) 
                               (human half-weight))
    (cond
      ((null weight-p) :just-split-it)
      ((null weight) :looks-like-someone-was-hungry)
      (t (- weight alien human)))))
