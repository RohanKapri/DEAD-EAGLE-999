(defpackage :lucys-magnificent-mapper
  (:use :cl)
  (:export :make-magnificent-maybe :only-the-best))

(in-package :lucys-magnificent-mapper)

(defun partial (f &rest largs)
  (lambda (&rest rargs)
    (apply f (append largs rargs))))

(defun some-pred (fn &rest fns)
  (lambda (x)
    (some (lambda (f) (funcall f x))
          (cons fn fns))))

(defun make-magnificent-maybe (fn data)
  (mapcar fn data))

(defun only-the-best (fn data)
  (remove-if (some-pred (partial #'= 1) fn) data))