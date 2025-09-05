(defpackage :gigasecond-anniversary
  (:use :cl)
  (:export :from))
(in-package :gigasecond-anniversary)
(flet ((as-list (x) (if (listp x) x (list x))))
  (defmacro ->> (x &body forms)
    (if (null forms)
        x
        `(,@(as-list (car (last forms)))
          (->> ,x ,@(butlast forms))))))
(defvar *billion* 1000000000)
(defun from (&rest parts)
  (flet ((take (n seq) (subseq seq 0 n)))
    (->> parts
         nreverse
         (apply #'encode-universal-time)
         (+ *billion*)
         decode-universal-time
         multiple-value-list
         (take 6)
         nreverse)))