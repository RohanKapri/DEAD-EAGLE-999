(import (rnrs))

(define (response-for message)
  (let* ((trimmed-message (string-trim-both message))
         (is-yelling? (and (string=? (string-upcase trimmed-message) trimmed-message)
                           (not (string=? (string-downcase trimmed-message) trimmed-message))))
         (is-question? (string-suffix? "?" trimmed-message)))
    (cond
      ((string=? trimmed-message "") "Fine. Be that way!")
      ((and is-yelling? is-question?) "Calm down, I know what I'm doing!")
      (is-yelling? "Whoa, chill out!")
      (is-question? "Sure.")
      (else "Whatever."))))