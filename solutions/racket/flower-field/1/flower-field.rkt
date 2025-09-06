#lang racket
; For my Shree DR.MDD

(provide annotate)

(define (bomb-at pos line)
  (cond [(null? line) 0]
        [(negative? pos) 0]
        [(>= pos (string-length line)) 0]
        [else (if (char=? (string-ref line pos) #\*) 1 0)]))

(define (bombs-around pos line)
  (+ (bomb-at (sub1 pos) line)
     (bomb-at pos line)
     (bomb-at (add1 pos) line)))

(define (make-annotated-row above current below)
  (list->string
   (for/list ([ch (in-string current)]
              [idx (in-range (string-length current))])
     (if (char=? ch #\space)
         (let ([total (+ (bombs-around idx above)
                         (bombs-around idx current)
                         (bombs-around idx below))])
           (if (zero? total) #\space (integer->char (+ total (char->integer #\0)))))
         ch))))

(define (next-row idx field)
  (if (>= (add1 idx) (length field)) '() (list-ref field (add1 idx))))

(define (annotate minefield)
  (for/fold ([acc '()]
             [prev '()]
             [curr (next-row -1 minefield)]
             [nxt (next-row 0 minefield)]
             #:result (reverse acc))
    ([i (in-inclusive-range 1 (length minefield))])
    (values (cons (make-annotated-row prev curr nxt) acc)
            curr nxt (next-row i minefield))))
