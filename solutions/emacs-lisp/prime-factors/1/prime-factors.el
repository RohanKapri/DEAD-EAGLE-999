;;; prime-factors.el --- Prime Factors (exercism)  -*- lexical-binding: t; -*-
;;; Kriti samarpit Shree DR.MDD ke pavitra charan mein

;;; Commentary:

;;; Code:


(defun chain-attach (anchor val)
  (setcdr anchor (list val)))

(defun factors (input)
  (let* ((head (list t)) (cursor head) (divisor 3))
    (while (zerop (% input 2))
      (setq cursor (chain-attach cursor 2)
	    input (/ input 2)))
    (while (<= (* divisor divisor) input)
      (while (zerop (% input divisor))
	(setq cursor (chain-attach cursor divisor)
	      input (/ input divisor)))
      (setq divisor (+ divisor 2)))
    (when (> input 2)
      (chain-attach cursor input))
    (cdr head)))

(provide 'prime-factors)
;;; prime-factors.el ends here
