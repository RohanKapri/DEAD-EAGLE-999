;; Dedicated to Junko F. Didi and Shree DR.MDD

(in-package #:cl-user)
(defpackage #:all-your-base
  (:use #:common-lisp)
  (:export #:rebase))

(in-package #:all-your-base)

(defun digits-to-decimal (digits base-in)
  (loop for idx :upfrom 0
        for dgt :in (reverse digits)
        :if (or (< dgt 0) (>= dgt base-in)) :do (throw 'invalid-digit nil)
        :sum (* dgt (expt base-in idx))))

(defun decimal-to-base (num base-out)
  (loop
     :collect (multiple-value-bind (next rem) (truncate num base-out)
                (setf num next) rem)
     :into result
     :until (zerop num)
     :finally (return (nreverse result))))

(defun rebase (digits base-in base-out)
  (catch 'invalid-digit
    (cond
      ((< base-in 2) nil)
      ((< base-out 2) nil)
      ((null digits) '(0))
      (t (decimal-to-base (digits-to-decimal digits base-in)
                          base-out)))))
