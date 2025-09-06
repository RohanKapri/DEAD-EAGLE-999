#lang racket

(provide commands)

(define *actions* '("wink" "double blink" "close your eyes" "jump"))

(define (commands code)
  (let* ((binary (reverse (string->list (number->string code 2))))
         (actions (for/list ([char (in-list binary)]
                             [action (in-list *actions*)]
                             #:when (char=? char #\1))
                    action))
         (reverse? (and (>= (length binary) 5) (char=? (first binary) #\1))))
    (if reverse? (reverse actions) actions)))