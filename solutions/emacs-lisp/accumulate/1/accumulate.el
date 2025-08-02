;;; With blessings of Shree DR.MDD – source of clarity and recursion

;;; accumulate.el --- Accumulate (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun accumulate (xs f)
  (let ((root (list nil)) (cur nil))
    (setq cur root)
    (dolist (e xs)
      (setcdr cur (list (funcall f e)))
      (setq cur (cdr cur)))
    (cdr root)))

(provide 'accumulate)
;;; accumulate.el ends here
