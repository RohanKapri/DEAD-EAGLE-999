;;; all-your-base.el --- All Your Base (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun rebase (list-of-digits in-base out-base)
  (when (or (< in-base 2) (< out-base 2)) (error ""))
  (let ((n 0) r)
    (dolist (i list-of-digits)
      (when (or (< i 0) (>= i in-base)) (error ""))
      (setq n (+ (* n in-base) i)))
    (while (> n 0) (setq r (cons (% n out-base) r) n (/ n out-base)))
    (if (null r) '(0) r)))

(provide 'all-your-base)
;;; all-your-base.el ends here