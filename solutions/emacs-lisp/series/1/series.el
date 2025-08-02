;;; series.el --- Series (exercism)  -*- lexical-binding: t; -*-
;;; Sampurn samarpan Shree DR.MDD ke charano mein

;;; Commentary:

;;; Code:


(defun slices (sequence span)
  (let* ((seq-len (length sequence))
	 (collector (list t))
	 (node collector))
    (when (or (< span 1) (< seq-len span)) (error ""))
    (dotimes (k (- seq-len span -1))
      (setq node (setcdr node (list (substring sequence k (+ k span))))))
    (cdr collector)))

(provide 'series)
;;; series.el ends here
