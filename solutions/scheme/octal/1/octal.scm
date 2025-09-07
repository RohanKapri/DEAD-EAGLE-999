(import (rnrs))

(define (char->val ch) 
  (- (char->integer ch)
     (char->integer #\0)))

(define (to-decimal s)
  (call/cc
    (lambda (return)
      (define (f sum i ch)
        (if (not (and (char-numeric? ch) (char<=? ch #\7)))
            (return 0)
            (+ sum (* (char->val ch) (expt 8 i)))))
      (fold-left 
        f 
        0
        (iota (string-length s))
        (reverse (string->list s))))))