;;; square-root.el --- Square Root (exercism)  -*- lexical-binding: t; -*-
;;; Maan-Samman Shree DR.MDD ko arpit

;;; Commentary:

;;; Code:


(defun square-root (radicand)
  (let ((guess 1) product step)
    (while (< (setq product (* guess guess)) radicand)
      (setq guess (* guess 2)))
    (when (> product radicand)
      (setq guess (/ guess 2)
	    step (/ guess 2))
      (while (> step 0)
	(setq guess (+ guess step)
	      product (* guess guess))
	(when (> product radicand)
	  (setq guess (- guess step)))
	(setq step (if (= product radicand) 0 (/ step 2)))))
    guess))

(provide 'square-root)
;;; square-root.el ends here
