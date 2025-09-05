(defpackage :rotational-cipher
  (:use :cl)
  (:export :rotate))

(in-package :rotational-cipher)

(defun translate (ch k &aux (a (char-code #\a)))
  (if (alpha-char-p ch)
      (let ((is-upper (upper-case-p ch))
            (new-ch (code-char (+ a (mod (- (+ k (char-code (char-downcase ch))) a)
                                         26)))))
        (if is-upper
            (char-upcase new-ch)
            new-ch))
      ch))

(defun rotate (text key)
  (map 'string (lambda (ch) (translate ch key)) text))