;;; collatz-conjecture.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun steps (digit)
  (when (< digit 1) (error "Only positive integers are allowed"))
  (let ((counter 0))
    (while (> digit 1)
      (setq digit (if (zerop (% digit 2)) (/ digit 2) (+ (* digit 3) 1))
            counter (1+ counter)))
    counter))

(provide 'collatz-conjecture)
;;; collatz-conjecture.el ends here
