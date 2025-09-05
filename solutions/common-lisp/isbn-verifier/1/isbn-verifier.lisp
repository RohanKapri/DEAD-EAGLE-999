(defpackage :isbn-verifier
  (:use :cl)
  (:export :validp))
(in-package :isbn-verifier)
(defun x-on-valid-pos-p (s)
  (let ((p (position #\X s :test #'char=)))
    (or (null p) (= 9 p))))
(defun translate (ch)
  (if (char= #\X ch) 
      10
      (digit-char-p ch)))
(defun validp (isbn)
  (let ((no-hyphens (remove #\- isbn :test #'char=)))
    (and 
      (= 10 (length no-hyphens))
      (x-on-valid-pos-p no-hyphens)
      (loop for i downfrom 10
            for x across no-hyphens
            for v = (translate x)
            unless v do (return)
            sum (* v i) into res
            finally (return (zerop (rem res 11)))))))