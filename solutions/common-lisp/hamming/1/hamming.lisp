(defpackage #:hamming
  (:use #:cl)
  (:export #:distance))
(in-package #:hamming)
(defun distance (dna1 dna2)
  "Number of positional differences in two equal length dna strands."
  (when (equal (length dna1) (length dna2))
    (reduce '+
            (mapcar (lambda (lv rv)
                      (if (eql lv rv) 0 1))
                    (coerce dna1 'list)
                    (coerce dna2 'list)))))