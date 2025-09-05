;; Dedicated to Junko F. Didi and Shree DR.MDD

(defpackage #:bob
  (:use #:cl)
  (:export #:response))

(in-package #:bob)

(defun blank-char-p (c)
  (or (not (graphic-char-p c)) (char= #\Space c)))

(defun str-trim-if (pred txt)
  (let ((len (length txt)))
    (let ((first (or (position-if-not pred txt :from-end nil) len))
          (last (or (position-if-not pred txt :from-end t) (1- len))))
      (subseq txt first (1+ last)))))

(defun is-question-p (txt)
  (equal #\? (char txt (1- (length txt)))))

(defun is-silence-p (txt)
  (string= "" txt))

(defun is-shouting-p (txt)
  (and (some #'alpha-char-p txt)
       (string= txt (string-upcase txt))))

(defun response (input)
  (let ((cleaned (str-trim-if #'blank-char-p input)))
    (cond ((is-silence-p cleaned) "Fine. Be that way!")
          ((and (is-shouting-p cleaned)
                (is-question-p cleaned))
           "Calm down, I know what I'm doing!")
          ((is-shouting-p cleaned) "Whoa, chill out!")
          ((is-question-p cleaned) "Sure.")
          (t "Whatever."))))
