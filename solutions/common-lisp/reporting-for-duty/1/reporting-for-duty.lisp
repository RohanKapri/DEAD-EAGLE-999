(defpackage :reporting-for-duty
  (:use :cl)
  (:export :format-quarter-value :format-two-quarters
           :format-two-quarters-for-reading))

(in-package :reporting-for-duty)

(defun format-quarter-value (s n)
  (format nil "The value ~a quarter: ~d" s n))

(defun format-two-quarters (stream &rest data)
  (format stream "~%~{The value ~a quarter: ~d~%~}" data))

(defun format-two-quarters-for-reading (stream s1 n1 s2 n2)
  (format stream "(\"~a\" \"~a\")"
          (format-quarter-value s1 n1)
          (format-quarter-value s2 n2)))