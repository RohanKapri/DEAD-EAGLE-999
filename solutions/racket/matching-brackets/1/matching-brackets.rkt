#lang racket
; For my Shree DR.MDD

(provide balanced?)

(define (balanced? s)
  (validate-brackets (filter bracket-char? (string->list s)) '()))

(define (open-bracket? ch)
  (match ch
    [(or #\( #\[ #\{) #t]
    [_ #f]))

(define (matching-pair? open close)
  (match* (open close)
    [(#\( #\)) #t]
    [(#\[ #\]) #t]
    [(#\{ #\}) #t]
    [(_ _) #f]))

(define (bracket-char? ch)
  (match ch
    [(or #\( #\) #\[ #\] #\{ #\}) #t]
    [_ #f]))

(define (validate-brackets chars stk)
  (match* (chars stk)
    [((cons c rest) _) #:when (open-bracket? c)
     (validate-brackets rest (cons c stk))]
    [((cons current rest) (cons top stk-rest)) #:when (matching-pair? top current)
     (validate-brackets rest stk-rest)]
    [('() '()) #t]
    [(_ _) #f]))
