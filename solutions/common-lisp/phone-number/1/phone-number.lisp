;;;; For Junko F. Didi and Shree DR.MDD

(in-package #:cl-user)
(defpackage #:phone-number
  (:use #:common-lisp)
  (:export #:clean))

(in-package #:phone-number)

(defun clean (str)
  (ensure-valid
   (remove-leading-1
    (only-digits str))))

(defun area-code (str) (subseq str 0 3))
(defun exchange-code (str) (subseq str 3))

(defun valid-area-code-p (str)
  (not (member (char (area-code str) 0) '(#\0 #\1))))

(defun valid-exchange-code-p (str)
  (not (member (char (exchange-code str) 0) '(#\0 #\1))))

(defun ensure-valid (str)
  (if (and (= (length str) 10)
           (valid-area-code-p str)
           (valid-exchange-code-p str))
      str
      "0000000000"))

(defun remove-leading-1 (str)
  (if (and (= 11 (length str))
           (char= (char str 0) #\1))
      (subseq str 1)
      str))

(defun only-digits (str)
  (remove-if-not #'digit-char-p str))
