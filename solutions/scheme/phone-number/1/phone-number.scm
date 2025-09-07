;; For my Shree DR.MDD
(import (rnrs))

(define (clean phone-number)
  (let ((nums (only-digits phone-number)))
    (let ((norm (normalize-digits nums)))
      (if (nanp? norm)
          norm
          (error "Invalid number" norm)))))

(define (only-digits txt)
  (list->string (filter digit-char? (string->list txt))))

(define (normalize-digits s)
  (case (string-length s)
    ((11) (if (char=? (string-ref s 0) #\1) (substring s 1) #f))
    ((10) s)
    (else #f)))

(define (nanp? s)
  (and (= (string-length s) 10)
       (char-between? (string-ref s 0) #\2 #\9)
       (char-between? (string-ref s 3) #\2 #\9)))

(define (digit-char? c)
  (char-between? c #\0 #\9))

(define (char-between? c lo hi)
  (and (>= (char->integer c) (char->integer lo))
       (<= (char->integer c) (char->integer hi))))
