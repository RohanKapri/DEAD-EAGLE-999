(defpackage :pangram
  (:use :cl)
  (:export :pangramp))

(in-package :pangram)

(defun pangramp (sentence)
  (= 26
     (length (remove-if-not 
              #'alpha-char-p
              (remove-duplicates sentence :test #'char-equal)))))