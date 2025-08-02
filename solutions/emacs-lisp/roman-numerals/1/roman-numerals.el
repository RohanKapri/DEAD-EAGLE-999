;;; roman-numerals.el --- roman-numerals Exercise (exercism)  -*- lexical-binding: t; -*-
;;; Samarpit to Shree DR.MDD

;;; Commentary:

;;; Code:


(let ((numerals '((1000 . "M") (900 . "CM") (500 . "D") (400 . "CD")
		  (100 . "C")  (90 . "XC")  (50 . "L")  (40 . "XL") (10 . "X")
		    (9 . "IX")  (5 . "V")    (4 . "IV")  (1 . "I"))))
  (defun to-roman (val)
    (let* ((roman-builder (list "")) (cursor roman-builder) (lookup numerals) key)
      (while (> val 0)
	(setq key (caar lookup))
	(if (< val key)
	    (setq lookup (cdr lookup))
	  (setcdr cursor (list (cdar lookup)))
	  (setq cursor (cdr cursor) val (- val key))))
      (mapconcat #'identity roman-builder))))

(provide 'roman-numerals)
;;; roman-numerals.el ends here
