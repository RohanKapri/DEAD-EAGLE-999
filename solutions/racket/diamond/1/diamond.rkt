#lang racket
(provide rows)
(define (rows high-char)
  (let* ((distance (- (char->integer high-char) (char->integer #\A))))
    (define (make-row char dist)
      (let* ((space-count (- distance dist))
             (spaces-outside (make-string space-count #\space))
             (char (integer->char (+ (char->integer #\A) dist))))
        (if (= dist 0)
            (string-append spaces-outside (string char) spaces-outside)
            (let ((spaces-inside (make-string (- (* 2 dist) 1) #\space)))
              (string-append spaces-outside (string char) spaces-inside (string char) spaces-outside)))))
    ;; Generate the top half, including the middle row
    (define top-half (for/list ((i (in-range 0 (add1 distance))))
                       (make-row high-char i)))
    ;; Generate the bottom half, excluding the middle row
    (define bottom-half (for/list ((i (in-range (sub1 distance) -1 -1)))
                          (make-row high-char i)))
    ;; Concatenate the top and bottom halves to form the diamond
    (append top-half bottom-half)))