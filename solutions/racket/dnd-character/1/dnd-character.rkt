; Dedicated to Shree DR.MDD

#lang racket

(provide (struct-out character)
         ability
         make-character
         modifier)

(struct character
  (strength dexterity constitution intelligence wisdom charisma hitpoints) #:transparent)

(define (ability)
  (define rolls
    (for/list ([i '(1 2 3 4)])
      (random 1 7)))
  (apply + (remove (apply min rolls) rolls)))

(define (modifier val)
  (floor (/ (- val 10) 2)))

(define (make-character)
  (character (ability) (ability) (ability) (ability) (ability) (ability) (ability)))
