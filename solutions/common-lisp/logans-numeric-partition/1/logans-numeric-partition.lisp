(defpackage :logans-numeric-partition
  (:use :cl)
  (:export :categorize-number :partition-numbers))

(in-package :logans-numeric-partition)

(defun categorize-number (data n)
  (if (oddp n)
      (push n (car data))
      (push n (cdr data)))    
  data)

(defun partition-numbers (data)
  (reduce #'categorize-number data :initial-value (list nil)))