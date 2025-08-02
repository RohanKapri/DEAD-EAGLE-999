;;; rna-transcription.el -- RNA Transcription (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

(let ((d '(?G "C" ?C "G" ?T "A" ?A "U")))
  (defun to-rna (strand)
    (mapconcat (lambda (n) (or (plist-get d n) (error ""))) strand)))

(provide 'rna-transcription)
;;; rna-transcription.el ends here