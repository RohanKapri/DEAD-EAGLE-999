;;; darts.el --- Darts (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun score (x y) (let ((d (+ (* x x) (* y y))))
  (cond ((> d 100) 0) ((> d 25) 1) ((> d 1) 5) (10))))


(provide 'darts)
;;; darts.el ends here