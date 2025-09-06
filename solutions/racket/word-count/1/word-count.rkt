#lang racket

(require racket/string)

(provide word-count)

(define (split-into-words s)
  (regexp-match* #rx"[a-zA-Z0-9]+('[a-zA-Z0-9]+)?" s))

(define (word-count str)
  (let* ([clean-str (string-downcase str)]
         [words (split-into-words clean-str)]
         [word-freq (foldl (lambda (word acc)
                             (hash-update acc word add1 0))
                           #hash()
                           words)])
    word-freq))