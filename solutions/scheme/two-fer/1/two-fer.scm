(import (rnrs))

(define (two-fer . maybe-name)
  ;; Check if maybe-name is provided and it is not an empty string
  (if (or (null? maybe-name) ;; No name provided
          (and (string? (car maybe-name)) ;; Ensure the first argument is a string
               (string=? (car maybe-name) ""))) ;; Check if the string is empty
      "One for you, one for me."
      (string-append "One for " (car maybe-name) ", one for me.")))