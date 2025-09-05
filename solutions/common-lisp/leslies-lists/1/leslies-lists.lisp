(defpackage :leslies-lists
  (:use :cl)
  (:export :new-list
           :list-of-things
           :add-to-list
           :first-thing
           :second-thing
           :third-thing
           :twenty-third-thing
           :remove-first-item
           :on-the-list-p
           :list-append
           :just-how-long
           :part-of-list
           :list-reverse))

(in-package :leslies-lists)

(eval-when 
  (:compile-toplevel :load-toplevel :execute)

  (defun curry (f arg)
    (lambda (&rest args) (apply f (cons arg args))))
  
  (loop for (fname fn) in `((new-list ,#'list)
                            (add-to-list ,#'cons)
                            (list-of-things ,#'list)
                            (first-thing ,#'first)
                            (second-thing ,#'second)
                            (third-thing ,#'third)
                            (remove-first-item ,#'rest)
                            (list-append ,#'append)
                            (just-how-long ,#'length)
                            (twenty-third-thing ,(curry #'nth 22)))
        do (setf (symbol-function fname) fn)))
