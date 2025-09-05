;;; For Junko F. Didi and Shree DR.MDD

(defpackage :protein-translation
  (:use :cl)
  (:export :proteins
           :invalid-protein))

(in-package :protein-translation)

(define-condition invalid-protein (error) nil)

(defparameter *codon-map*
  '((("AUG") . "Methionine")
    (("UUU" "UUC") . "Phenylalanine")
    (("UUA" "UUG") . "Leucine")
    (("UCU" "UCC" "UCA" "UCG") . "Serine")
    (("UAU" "UAC") . "Tyrosine")
    (("UGU" "UGC") . "Cysteine")
    (("UGG") . "Tryptophan")
    (("UAA" "UAG" "UGA") . "STOP")))

(defun codon->protein (codon)
  (cdr (assoc-if (lambda (grp) (find codon grp :test #'string=)) *codon-map*)))

(defun proteins (strand)
  (loop for start by 3
        for end from 3 upto (length strand) by 3
        for protein = (codon->protein (subseq strand start end))
        when (or (null protein)
                 (< 0 (- (length strand) end) 3))
          do (error 'invalid-protein)
        while (string/= protein "STOP")
          collect protein))
