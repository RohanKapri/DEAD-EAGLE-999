;;; knapsack.el --- Knapsack (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun maximum-value (maximum-weight items)
  (let ((a (make-vector (1+ maximum-weight) 0)) i x)
    (pcase-dolist (`((:weight . ,w) (:value . ,v)) items)
      (setq i maximum-weight) (while (>= i w)
	(setq x (+ v (aref a (- i w))))
	(when (> x (aref a i)) (aset a i x)) (cl-decf i)))
    (aref a maximum-weight)))


(provide 'knapsack)
;;; knapsack.el ends here
