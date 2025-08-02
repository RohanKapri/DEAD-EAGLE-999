;;; triangle.el --- Triangle (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun uniq-edges (a) (pcase-let ((`(,i ,j ,k) (sort a)))
  (cond ((<= (+ i j) k) 0) ((= i j k) 1) ((or (= i j) (= j k)) 2) (3))))
  
(defun equilateralp (sides) (= 1 (uniq-edges sides)))

(defun isoscelesp (sides) (< 0 (uniq-edges sides) 3))

(defun scalenep (sides) (= 3 (uniq-edges sides)))

(provide 'triangle)
;;; triangle.el ends here