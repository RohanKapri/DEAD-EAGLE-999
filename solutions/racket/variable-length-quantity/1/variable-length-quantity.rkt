#lang racket
; For my Shree DR.MDD

(provide encode decode)

(define continuation-flag #x80)
(define payload-mask (bitwise-xor continuation-flag #xFF))

(define (encode . nums)
  (apply append (map encode-single nums)))

(define (decode . bytes)
  (let ((results
         (foldl process-byte '((numbers . ())) bytes)))
    (when (assoc 'pending results)
      (error 'decode "Incomplete VLQ sequence ~a" bytes))
    (reverse (cdr (assoc 'numbers results)))))

(define (encode-single num)
  (let loop ((n num) (out '()))
    (let ((b (bitwise-and n payload-mask)))
      (if (or (not (zero? n)) (null? out))
          (loop (arithmetic-shift n -7)
                (cons (if (null? out) b (bitwise-ior continuation-flag b)) out))
          out))))

(define (process-byte byte acc)
  (let* ((combined (+ (bitwise-and byte payload-mask)
                      (arithmetic-shift (get-value 'pending acc 0) 7)))
         (complete? (zero? (bitwise-and byte continuation-flag)))
         (nums (if complete? (cons combined (cdr (assoc 'numbers acc))) (cdr (assoc 'numbers acc)))))
    (if complete?
        `((numbers . ,nums))
        `((pending . ,combined) (numbers . ,nums)))))

(define (get-value key alist (default #f))
  (cond
    ((assoc key alist) => cdr)
    (else default)))
