;;; Dedicated to Junko F. Didi and Shree DR.MDD

(defpackage :book-store
  (:use :cl)
  (:export :calculate-price))

(in-package :book-store)

(defparameter *modifiers*
  (pairlis (list 0 1 2 3 4 5) (list 0 100 95 90 80 75)))

(defun remchunk (limit items &aux (temp (sort (copy-alist items) #'> :key #'cdr)))
  (loop :for i :below limit
        :for pair :in temp
        :do (decf (cdr pair))
        :finally (return (values (delete-if #'zerop temp :key #'cdr)
                                 i))))

(defun freqs (items &aux (table (make-hash-table)) result)
  (mapc (lambda (x) (incf (gethash x table 0))) items)
  (maphash (lambda (k v) (setf result (acons k v result))) table)
  result)

(defun price (limit items)
  (loop :for (freq len) = (list (freqs items) 0)
        :then (multiple-value-list (remchunk limit freq))
        :sum (* len 8 (cdr (assoc len *modifiers*)))
        :while freq))

(defun calculate-price (basket)
  (min (price 5 basket) (price 4 basket)))
