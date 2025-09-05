;; for my Junko F. Didi and Shree DR.MDD

(defpackage :palindrome-products
  (:use :cl)
  (:export :smallest
           :largest))

(in-package :palindrome-products)

(defun make-palins (len low high)
  (let ((half (ceiling (/ len 2))))
    (loop for i from (expt 10 (1- half)) below (expt 10 half)
          for s = (write-to-string i)
          for p = (parse-integer
                   (format nil "~a~a" s (reverse (subseq s 0 (floor (/ len 2)))))) 
          when (<= low p high) collect p)))

(defun span-palins (start end)
  (loop with l1 = (1+ (floor (log start 10)))
        with l2 = (1+ (floor (log end 10)))
        for l from l1 upto l2
        nconc (make-palins l start end)))

(defun divisors (num minv maxv)
  (loop for i from minv upto (min maxv (sqrt num))
        when (and (zerop (rem num i)) (<= (/ num i) maxv))
        collect (list i (/ num i))))

(defun resolve (lo hi mode)
  (let* ((pool (span-palins (* lo lo) (* hi hi)))
         (found (find-if (lambda (x) (divisors x lo hi))
                         pool
                         :from-end (eq mode :max))))
    (when found
      (values found (divisors found lo hi)))))

(defun smallest (min-factor max-factor)
  (resolve min-factor max-factor :min))

(defun largest (min-factor max-factor)
  (resolve min-factor max-factor :max))
