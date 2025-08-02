;;; sum-of-multiples.el --- Sum of Multiples (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun sum (factors limit) (let ((d (make-hash-table)) (r 0))
  (dolist (n factors) (unless (zerop n)
    (dotimes (i (/ (1- limit) n)) (puthash (* n (1+ i)) t d))))
  (maphash (lambda (i _) (setq r (+ r i))) d) r))


(provide 'sum-of-multiples)
;;; sum-of-multiples.el ends here