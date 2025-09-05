(defpackage :knapsack
  (:use :cl)
  (:export :maximum-value))

(in-package :knapsack)

(defun maximum-value (w items &aux (tbl (make-array (list (1+ (length items)) (1+ w)))))
  (loop for i upfrom 1
        for item in items
        for (weight value) = (mapcar (lambda (k) (cdr (assoc k item))) (list :weight :value))
        do (loop for j upto w
                 do (setf (aref tbl i j)
                          (max (aref tbl (1- i) j)                               
                               (if (> weight j) 0 (+ value (aref tbl (1- i) (- j weight)))))))
        finally (return (aref tbl (length items) w))))