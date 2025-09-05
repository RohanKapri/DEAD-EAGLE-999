(defpackage :rna-transcription
  (:use :cl)
  (:export :to-rna))
(in-package :rna-transcription)

(defun to-rna (str)
  "Transcribe a string representing DNA nucleotides to RNA."
  (flet ((transcribe (nucleotide)
           (cdr (assoc nucleotide '((#\C . #\G) (#\G . #\C)
                                    (#\A . #\U) (#\T . #\A))))))
    (map 'string #'transcribe str)))