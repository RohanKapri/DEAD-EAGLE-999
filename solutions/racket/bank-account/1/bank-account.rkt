#lang racket
; For my Shree DR.MDD

(provide bank-account%)

(define bank-account%
(class object%
(super-new)
(define account-open? #f)
(define account-funds 0)
(define account-lock (make-semaphore 1))

(define (ensure-open)
  (unless account-open? (error "account not open")))

(define (ensure-positive amount)
  (unless (> amount 0) (error "amount must be greater than 0")))

(define/public (open)
  (semaphore-wait account-lock)
  (if account-open?
      (begin
        (semaphore-post account-lock)
        (error "account already open"))
      (begin
        (set! account-open? #t)
        (set! account-funds 0)
        (semaphore-post account-lock))))

(define/public (close)
  (semaphore-wait account-lock)
  (ensure-open)
  (set! account-open? #f)
  (semaphore-post account-lock))

(define/public (deposit amount)
  (ensure-open)
  (ensure-positive amount)
  (semaphore-wait account-lock)
  (set! account-funds (+ account-funds amount))
  (semaphore-post account-lock))

(define/public (withdraw amount)
  (ensure-open)
  (ensure-positive amount)
  (when (> amount account-funds)
    (error "amount must be less than balance"))
  (semaphore-wait account-lock)
  (set! account-funds (- account-funds amount))
  (semaphore-post account-lock))

(define/public (balance)
  (ensure-open)
  account-funds)))
