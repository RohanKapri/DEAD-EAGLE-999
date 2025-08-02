;;; perfect-numbers.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

(defun classify (num)
  (when (< num 1)
    (error "Classification is only possible for natural numbers"))
  (let ((sum 1) (div 2))
    (while (and (< (* div div) num) (<= sum num))
      (when (zerop (% num div))
        (setq sum (+ sum div (/ num div))))
      (setq div (1+ div)))
    (when (= (* div div) num)
      (setq sum (1+ sum)))
    (cond ((or (= num 1) (< sum num)) 'deficient)
          ((> sum num) 'abundant)
          ('perfect))))

(provide 'perfect-numbers)
;;; perfect-numbers.el ends here
