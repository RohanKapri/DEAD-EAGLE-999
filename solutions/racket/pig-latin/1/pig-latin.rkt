#lang racket

(provide translate)

(define (vowel-sound? word)
  (regexp-match? #rx"^(a|e|i|o|u|xr|yt)" word))

(define (translate-word word)
  (cond
    [(vowel-sound? word)
     (string-append word "ay")]
    [(equal? (substring word 0 1) "y")
     (string-append (substring word 1) "yay")]
    [else
     (let* ((match (regexp-match #rx"^([^aeiou]?qu|[^aeiouy]+)(.*)" word))
            (prefix (if match (cadr match) ""))
            (suffix (if match (caddr match) word)))
       (string-append suffix prefix "ay"))]))

(define (translate text)
  (let ((words (string-split text)))
    (string-join (map translate-word words) " ")))
