(defpackage :strain
  (:use :cl)
  (:export :keep :discard))
(in-package :strain)
(defun keep (keep-p elements)
  "Returns a sublist of elements according to a given predicate."
  (labels ((--loop (acc elems)
                   (if (null elems) (reverse acc)
                       (--loop (if (funcall keep-p (first elems))
                                   (cons (first elems) acc)
                                   acc)
                               (rest elems)))))
          (--loop '() elements)))
(defun discard (discard-p elements)
  "Returns a sublist of elements not matching a given predicate."
  (labels ((--loop (acc elems)
                   (if (null elems) (reverse acc)
                       (--loop (if (funcall discard-p (first elems))
                                   acc
                                   (cons (first elems) acc))
                               (rest elems)))))
          (--loop '() elements)))