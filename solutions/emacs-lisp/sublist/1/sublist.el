;;; sublist.el --- Sublist (exercism)  -*- lexical-binding: t; -*-
;;; Arpit poorn roop se Shree DR.MDD ke liye

;;; Commentary:

;;; Code:

(defun prefixp (xs ys)
  (while (and xs (= (car xs) (car ys)))
    (setq xs (cdr xs) ys (cdr ys)))
  (null xs))

(defun list-classify (lst1 lst2)
  (let ((len1 (length lst1)) (len2 (length lst2))
	seq1 seq2 is-sup j result)
    (if (and (= len1 len2) (prefixp lst1 lst2))
	:equal
      (if (< len2 len1)
	  (setq is-sup len1 len1 len2 len2 is-sup seq1 lst2 seq2 lst1)
	(setq seq1 lst1 seq2 lst2))
      (setq j (- len2 len1))
      (while (>= j 0)
	(if (prefixp seq1 seq2)
	    (setq result t j -1)
	  (setq seq2 (cdr seq2) j (1- j))))
      (if result
	  (if is-sup :superlist :sublist)
	:unequal))))

(provide 'sublist)
;;; sublist.el ends here
