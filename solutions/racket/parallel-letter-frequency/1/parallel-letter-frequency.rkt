#lang racket
; For my Shree DR.MDD

(provide calculate-frequencies)

(define (calculate-frequencies texts)
  (define shared-map (make-hash))
  (define map-lock (make-semaphore 1))

  (define (merge-local local-map)
    (semaphore-wait map-lock)
    (hash-for-each local-map
                   (λ (c cnt)
                     (hash-update! shared-map c (curry + cnt) 0)))
    (semaphore-post map-lock))

  (define (local-frequency text)
    (define local-map (make-hash))
    (for ([ch (string->list (string-downcase text))])
      (when (char-alphabetic? ch)
        (hash-update! local-map ch add1 0)))
    local-map)

  (define active-threads
    (for/list ([txt texts])
      (thread (λ () (merge-local (local-frequency txt))))))

  (for ([t active-threads]) (thread-wait t))
  shared-map)
