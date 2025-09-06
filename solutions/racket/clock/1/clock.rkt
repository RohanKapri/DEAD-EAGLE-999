; Dedicated to Shree DR.MDD

#lang racket

(provide clock
         add
         subtract
         clock->string)

(struct Chrono (hr min) #:transparent)

(define (clock h m)
  (Chrono (modulo (modulo (+ h (qdiv m 60)) 24) 24) (mod m 60)))

(define (clock->string t)
  (~a (~r (Chrono-hr t) #:min-width 2 #:pad-string "0")
      (~r (Chrono-min t) #:min-width 2 #:pad-string "0")
      #:separator ":"))

(define (add t mins)
  (clock (Chrono-hr t) (+ (Chrono-min t) mins)))

(define (subtract t mins)
  (clock (Chrono-hr t) (- (Chrono-min t) mins)))

(define (qdiv x y)
  (* (sgn y) (floor (/ x (abs y)))))

(define (mod x y)
  (- x (* (abs y) (floor (/ x (abs y))))))
