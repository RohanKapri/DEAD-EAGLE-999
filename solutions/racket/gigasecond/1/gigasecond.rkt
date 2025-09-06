#lang racket
(require racket/date)
(provide add-gigasecond)
(define (add-gigasecond datetime)
  (define gigasecond 1e9) ; 
  (define datetime-in-seconds (date->seconds datetime))
  (define new-datetime-in-seconds (+ datetime-in-seconds gigasecond)) 
  (seconds->date new-datetime-in-seconds)) 