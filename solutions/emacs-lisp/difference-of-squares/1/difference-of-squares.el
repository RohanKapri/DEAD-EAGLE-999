;;; difference-of-squares.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

(defun square-of-sum (limit)
  (expt (/ (* limit (1+ limit)) 2) 2))

(defun sum-of-squares (limit)
  (/ (* limit (1+ limit) (1+ (* 2 limit))) 6))

(defun difference (limit)
  (- (square-of-sum limit) (sum-of-squares limit)))

(provide 'difference-of-squares)
;;; difference-of-squares.el ends here
