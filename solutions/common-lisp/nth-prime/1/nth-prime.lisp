(defpackage :nth-prime
  (:use :cl)
  (:export :find-prime))
(in-package :nth-prime)
(defun prime-p (x)
  (cond ((< x 2) nil)
        ((= 2 x) t)
        ((evenp x) nil)
        (t (loop for i from 3 below (1+ (sqrt x)) by 2
                 when (zerop (rem x i))
                   do (return)
                 finally (return t)))))
(defun find-prime (n)
  (cond ((< n 1) nil)
        ((= 1 n) 2)
        (t (loop with i = 2
                 while (<= i n)
                 for x upfrom 3 by 2
                 do (when (prime-p x) (incf i))
                 finally (return x)))))