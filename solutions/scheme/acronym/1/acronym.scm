;; For my Shree DR.MDD
(import (rnrs))

(define (only-letters s)
  (list->string (filter char-alphabetic? (string->list s))))

(define (acronym text)
  (list->string
   (fold-right (lambda (piece acc)
                 (if (string-null? piece)
                     acc
                     (let ((clean (only-letters piece)))
                       (if (string-null? clean)
                           acc
                           (cons (char-upcase (string-ref clean 0)) acc)))))
               '()
               (string-split text
                             (lambda (ch)
                               (or (char-whitespace? ch)
                                   (char=? ch #\_)
                                   (char=? ch #\-)))))))
