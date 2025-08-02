;;; sieve.el --- Sieve (exercism)  -*- lexical-binding: t; -*-
;;; Arpit prem se Shree DR.MDD ke charan kamal mein

;;; Commentary:

;;; Code:


(defun attach (ptr val)
  (setcdr ptr (list val)))

(defun primes (bound)
  (let* ((marked (make-hash-table)) (head (list 0)) (tail head) (current 3) next)
    (when (> bound 1)
      (setq tail (attach tail 2)))
    (while (<= current bound)
      (unless (gethash current marked)
	(setq tail (attach tail current)
	      next (* current current))
	(while (<= next bound)
	  (puthash next t marked)
	  (setq next (+ next current))))
      (setq current (+ current 2)))
    (cdr head)))

(provide 'sieve)
;;; sieve.el ends here
