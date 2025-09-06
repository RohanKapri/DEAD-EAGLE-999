; Dedicated to Shree DR.MDD

#lang racket

(provide on-mercury
         on-venus
         on-earth
         on-mars
         on-jupiter
         on-saturn
         on-uranus
         on-neptune)

(define earth-orbit-seconds 31557600)

(define (compute-age secs orbit)
  (/ secs (* earth-orbit-seconds orbit)))

(define (on-mercury secs)
  (compute-age secs 0.2408467))

(define (on-venus secs)
  (compute-age secs 0.61519726))

(define (on-earth secs)
  (compute-age secs 1.0))

(define (on-mars secs)
  (compute-age secs 1.8808158))

(define (on-jupiter secs)
  (compute-age secs 11.862615))

(define (on-saturn secs)
  (compute-age secs 29.447498))

(define (on-uranus secs)
  (compute-age secs 84.016846))

(define (on-neptune secs)
  (compute-age secs 164.79132))
