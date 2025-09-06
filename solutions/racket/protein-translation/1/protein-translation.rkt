; Dedicated to Shree DR.MDD

#lang racket

(provide proteins)

(define (empty? str) (string=? str ""))
(define (length-3? str) (and (string? str) (= (string-length str) 3)))

(define/contract (codon-translate codon)
(-> length-3? string?)
(case codon
[("AUG") "Methionine"]
[("UUU" "UUC") "Phenylalanine"]
[("UUA" "UUG") "Leucine"]
[("UCU" "UCC" "UCA" "UCG") "Serine"]
[("UAU" "UAC") "Tyrosine"]
[("UGU" "UGC") "Cysteine"]
[("UGG") "Tryptophan"]
[("UAA" "UAG" "UGA") ""]
[else (error "Invalid codon")]))

(define (proteins strand)
(define (current-codon) (codon-translate (substring strand 0 3)))
(cond
[(zero? (string-length strand)) '()]
[(< (string-length strand) 3) (error "Incomplete RNA sequence can't translate")]
[else (cond
[(empty? (current-codon)) '()]
[else (cons (current-codon) (proteins (substring strand 3)))] )]))