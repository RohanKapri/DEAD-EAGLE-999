;;; nucleotide-count.el --- nucleotide-count Exercise (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun nucleotide-count (sequence) (let ((d (make-hash-table)) n r)
  (dolist (c '(?A ?C ?G ?T)) (puthash c 0 d))
  (dolist (c (string-to-list sequence))
    (setq n (gethash c d)) (unless n (error "")) (puthash c (1+ n) d))
  (maphash (lambda (k v) (setq r (cons (cons k v) r))) d) r))


(provide 'nucleotide-count)
;;; nucleotide-count.el ends here