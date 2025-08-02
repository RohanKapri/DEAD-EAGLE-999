;;; say.el --- Say (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(define-error 'out-of-range "")
(defun suppend (a x) (setcdr a (list x)))

(let ((small ["" "one" "two" "three" "four" "five" "six" "seven" "eight"
	      "nine" "ten" "eleven" "twelve" "thirteen" "fourteen"
	      "fifteen" "sixteen" "seventeen" "eighteen" "nineteen"])
      (medium
	["" "" "twen" "thir" "for" "fif" "six" "seven" "eigh" "nine"])
      (large ["" "thousand" "million" "billion"]))

  (defun parse (n) (let* ((h (list t)) (r h) (b (list t)) (a b))
    (when (> n 99) (setq r (suppend r (aref small (/ n 100)))
			 r (suppend r "hundred")  n (% n 100)))
    (when (> n 19) (setq
      a (suppend a (concat (aref medium (/ n 10)) "ty"))  n (% n 10)))
    (when (> n 0) (setq a (suppend a (aref small n)))) (setq a (cdr b))
    (when a (setq r (suppend r (mapconcat #'identity a "-"))))
    (mapconcat #'identity (cdr h) " ")))

  (defun say (number) (let ((i 0) n r)
    (unless (< -1 number 1000000000000) (signal 'out-of-range nil))
    (if (zerop number) "zero"
      (while (> number 0)
	(setq n (% number 1000)  number (/ number 1000))
	(when (> n 0)
	  (when (> i 0) (push (aref large i) r)) (push (parse n) r))
	(cl-incf i))
      (mapconcat #'identity r " ")))))


(provide 'say)
;;; say.el ends here
