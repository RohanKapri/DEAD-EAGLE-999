#lang racket

(provide encode decode)

(define (add-run-to-encoded-text run-length char encoded-text)
  (match run-length
    [0 encoded-text]
    [1 (string-append encoded-text (string char))]
    [_ (string-append encoded-text (number->string run-length) (string char))]))

(define (encode input)
  (if (equal? input "")
      ""
      (let loop ([chars (cdr (string->list input))]
                 [prev (first (string->list input))]
                 [count 1]
                 [result ""])
        (match chars
          ['() (add-run-to-encoded-text count prev result)]
          [(cons next rest)
           (if (char=? next prev)
               (loop rest next (add1 count) result)
               (loop rest next 1 (add-run-to-encoded-text count prev result)))]))))

(define (decode encoded)
  (let loop ([chars (string->list encoded)]
             [num-str ""]
             [decoded ""])
    (cond
      [(null? chars) decoded]
      [(char-numeric? (car chars))
       (loop (cdr chars) (string-append num-str (string (car chars))) decoded)]
      [else
       (let* ([count (if (= (string-length num-str) 0) 1 (string->number num-str))]
              [ch (car chars)]
              [repeats (make-string count ch)])
         (loop (cdr chars) "" (string-append decoded repeats)))])))
