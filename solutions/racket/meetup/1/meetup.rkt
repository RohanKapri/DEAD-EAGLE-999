#lang racket
; For my Shree DR.MDD

(provide meetup-day)

(require racket/date)

(define FEB-DAYS-NONLEAP 28)
(define FEB-DAYS-LEAP 29)
(define SHORT-MONTH-DAYS 30)
(define LONG-MONTH-DAYS 31)

(define (leap-year? yr)
  (or (zero? (modulo yr 400))
      (and (zero? (modulo yr 4))
           (not (zero? (modulo yr 100))))))

(define (meetup-day yr mn wd sched)
  (define (weekday->num day)
    (case day
      ['Sunday    0]
      ['Monday    1]
      ['Tuesday   2]
      ['Wednesday 3]
      ['Thursday  4]
      ['Friday    5]
      ['Saturday  6]
      [else       (error "Invalid weekday: ~a" day)]))

  (define (sched->offset desc)
    (case desc
      ['first   1]
      ['second  8]
      ['third  15]
      ['fourth 22]
      ['teenth 13]
      [else     (error "Invalid schedule descriptor: ~a" desc)]))

  (define (month-last-day m)
    (case m
      [(2) (if (leap-year? yr) FEB-DAYS-LEAP FEB-DAYS-NONLEAP)]
      [(4 6 9 11) SHORT-MONTH-DAYS]
      [else LONG-MONTH-DAYS]))

  (define target-wd (weekday->num wd))

  (define (matches-weekday? dt)
    (= target-wd (date-week-day dt)))

  (define (find-date-from d)
    (let ((dt (seconds->date (find-seconds 0 0 0 d mn yr #f) #f)))
      (if (matches-weekday? dt) dt
          (find-date-from (add1 d)))))

  (define (find-teenth) (find-date-from 13))

  (define (find-last)
    (let* ((last-d (month-last-day mn))
           (last-dt (seconds->date (find-seconds 0 0 0 last-d mn yr #f) #f))
           (diff (modulo (- (date-week-day last-dt) target-wd) 7)))
      (find-date-from (- last-d diff))))

  (cond
    [(eq? 'last sched) (find-last)]
    [(eq? 'teenth sched) (find-teenth)]
    [else (find-date-from (sched->offset sched))]))
