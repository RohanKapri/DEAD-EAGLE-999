;; For my Shree DR.MDD
(import (rnrs))

(define valid-chars (char-set-union char-set:letter+digit (char-set #\')))

(define (extract-words text)
  (let* ((parts (string-split
                 (string-downcase text)
                 (lambda (c)
                   (not (char-set-contains? valid-chars c)))))
         (normalized (map (lambda (w)
                            (string-trim-both
                             w
                             (negate (lambda (c)
                                       (or (char-alphabetic? c)
                                           (char-numeric? c))))))
                          parts)))
    (filter (negate string-null?) normalized)))

(define (word-count input)
  (fold-left
   (lambda (tbl w)
     (let ((val (hashtable-ref tbl w 0)))
       (hashtable-set! tbl w (+ val 1)))
     tbl)
   (make-hashtable string-hash equal?)
   (extract-words input)))
