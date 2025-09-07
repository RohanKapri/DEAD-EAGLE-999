(import (rnrs))

(define dna-to-rna-map
  (let ((mappings (list (cons #\G #\C) (cons #\C #\G) (cons #\T #\A) (cons #\A #\U))))
    (lambda (char)
      (let ((pair (assoc char mappings)))
        (if pair
            (cdr pair)
            (error "Invalid DNA nucleotide" char))))))

(define (dna->rna dna)
  (list->string
   (map dna-to-rna-map
        (string->list dna))))