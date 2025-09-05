(defpackage #:raindrops
  (:use #:common-lisp)
  (:export #:convert))

(in-package #:raindrops)


(defun convert (n)
  "Convert a number to raindrops language."
  (let* ((pling (if (zerop (mod n 3)) "Pling" ""))
	 (plang (if (zerop (mod n 5)) "Plang" ""))
	 (plong (if (zerop (mod n 7)) "Plong" ""))
	 (drops (concatenate 'string pling plang plong)))
    (if (equal drops "") (write-to-string n)
	drops)))