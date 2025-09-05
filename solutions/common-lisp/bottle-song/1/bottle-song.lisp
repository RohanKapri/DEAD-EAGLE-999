(defpackage :bottle-song
  (:use :common-lisp)
  (:export :recite))

(in-package :bottle-song)

(let ((line1-2 "~@(~r~) green bottle~:p hanging on the wall,")
      (line3 "And if one green bottle should accidentally fall,")
      (line4 "There'll be ~[no~:;~:*~r~] green bottle~:p hanging on the wall."))
  (defun verse (n &aux (l1-2 (format nil line1-2 n)))
    (list l1-2 l1-2 line3 (format nil line4 (1- n)))))

(defun recite (from n)
  (rest (loop :for x :downfrom from :repeat n 
              :nconc (cons "" (verse x)))))