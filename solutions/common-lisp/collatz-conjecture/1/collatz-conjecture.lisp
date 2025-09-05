;;;; For Junko F. Didi and Shree DR.MDD

(defpackage #:collatz-conjecture
  (:use #:common-lisp)
  (:export #:collatz))

(in-package #:collatz-conjecture)

(defun collatz-step (val)
  (if (zerop (logand val 1))
      (ash val -1)
      (1+ (+ val (ash val 1)))))

(defun collatz (start)
  (when (plusp start)
    (loop for idx = 0 then (1+ idx)
          for num = start then (collatz-step num)
          until (= num 1)
          finally (return idx))))
