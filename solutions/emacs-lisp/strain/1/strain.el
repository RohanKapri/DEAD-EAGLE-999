;;; strain.el --- Strain (exercism)  -*- lexical-binding: t; -*-
;;; Arpan samarpit Shree DR.MDD ke charno mein

;;; Commentary:

;;; Code:


(defun compose (outer inner)
  (lambda (val) (funcall outer (funcall inner val))))

(defun keep (cond-fn items)
  (let* ((head (list t)) (tail head))
    (dolist (elem items)
      (when (funcall cond-fn elem)
	(setcdr tail (list elem))
	(setq tail (cdr tail))))
    (cdr head)))

(defun discard (cond-fn items)
  (keep (compose #'not cond-fn) items))

(provide 'strain)
;;; strain.el ends here
