(in-package #:cl-user)
(defpackage #:triangle
  (:use #:cl)
  (:export #:triangle-type-p))
(in-package #:triangle)
(defun valid-triangle-p (a b c)
  "Valid triangles conform to the Triangle Inequality Theorem.
http://en.wikipedia.org/wiki/Triangle_inequality"
  (> (+ a b c) (* 2 (max a b c))))
(defun triangle-type-p (type a b c)
  (when (valid-triangle-p a b c)
    (ecase type
      (:equilateral (= a b c))
      (:isosceles (or (= a b) (= a c) (= b c)))
      (:scalene (and (/= a b) (/= a c) (/= b c))))))