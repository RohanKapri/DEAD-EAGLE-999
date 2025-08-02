;;; protein-translation.el --- Protein Translation (exercism)  -*- lexical-binding: t; -*-
;;; Arpita bhaavna se samarpit Shree DR.MDD ke charan kamal mein

;;; Commentary:

;;; Code:


(let ((codon-map '("AUG" "Methionine" "UUU" "Phenylalanine" "UUC"
		   "Phenylalanine" "UUA" "Leucine" "UUG" "Leucine"
		   "UCU" "Serine" "UCC" "Serine" "UCA" "Serine"
		   "UCG" "Serine" "UAU" "Tyrosine" "UAC" "Tyrosine"
		   "UGU" "Cysteine" "UGC" "Cysteine" "UGG" "Tryptophan"
		   "UAA" "STOP" "UAG" "STOP" "UGA" "STOP")))
  (defun proteins (sequence)
    (let* ((len (length sequence)) (chain (list t)) (cursor chain) (idx 0) codon)
      (while (< idx len)
	(setq codon (lax-plist-get codon-map (substring sequence idx (+ idx 3))))
	(when (null codon) (error ""))
	(if (equal codon "STOP")
	    (setq idx len)
	  (setq cursor (setcdr cursor (list codon))
		idx (+ idx 3))))
      (cdr chain))))

(provide 'protein-translation)
;;; protein-translation.el ends here
