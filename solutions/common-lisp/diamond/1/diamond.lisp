(defpackage :diamond
  (:use :cl)
  (:export :rows))
(in-package :diamond)
(defparameter *alphabet* "ABCDEFGHIJKLMNOPQRSTUVWXYZ")
(defun rombus (y x last-pos)
  (let ((ly (- last-pos y))
        (lx (- last-pos x)))
    (list (list y x) (list y lx) (list ly x) (list ly lx))))
(defun space-field (size)
  (loop repeat size collect (make-string size :initial-element #\ )))
(defun rows (ch)
  (let* ((n (1+ (position ch *alphabet* :test #'char=)))
         (size (+ n n -1))
         (res (space-field size)))
    (loop for x from (1- n) downto 0
          as ch across *alphabet*
          do (loop for (y x) in (rombus (- n x 1) x (1- size)) do (setf (elt (elt res y) x) ch))
          finally (return res))))