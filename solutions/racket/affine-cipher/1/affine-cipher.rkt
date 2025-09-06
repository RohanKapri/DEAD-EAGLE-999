#lang racket
(require racket/contract)

(provide (contract-out
          [encode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]
          [decode (string?
                   exact-nonnegative-integer?
                   exact-nonnegative-integer? . -> . string?)]))

(define (char->num c)
  (- (char->integer (char-downcase c)) (char->integer #\a)))

(define (num->char n)
  (integer->char (+ n (char->integer #\a))))

(define (add-spaces char-list)
  (let loop ([in char-list]
             [out-list '()])
    (cond
     [(null? in) (cdr out-list)]
     [(> 5 (length in)) (loop '() (append out-list (list #\space) in))]
     [else (loop (drop in 5) (append out-list (list #\space) (take in 5)))])))

(define (transformed-cons fn c acc)
  (cond
   [(char-numeric? c) (cons c acc)]
   [(char-alphabetic? c) (cons (fn c) acc)]
   [else acc]))

(define (encode msg a b)
  (let-values ([(dummy _) (euclid a 26)]) ;; just to see if a is coprime to 26
    (define (enc-char c)
      (num->char (modulo (+ (* a (char->num c)) b) 26)))
    (list->string
     (add-spaces
      (foldr (curry transformed-cons enc-char) '() (string->list msg))))))

(define (euclid a m)
  (if (zero? a)
      (if (= 1 m)
          (values 0 1)
          (raise (exn:fail (format "Argument a=~a and ~a are not coprime." a m)
                           (current-continuation-marks))))
      (let-values ([(x1 y1) (euclid (modulo m a) a)])
        (values (- y1 (* x1 (quotient m a)))
                x1))))

(define (calc-mmi a m)
  (let-values ([(i _) (euclid a m)])
    (modulo (+ (modulo i m) m) m)))

(define (decode msg a b)
  (let ([mmi (calc-mmi a 26)])
    (define (dec-char c)
      (num->char (modulo (* mmi (- (char->num c) b)) 26)))
    (list->string
     (foldr (curry transformed-cons dec-char) '() (string->list msg)))))