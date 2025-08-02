;;; scrabble-score.el --- Scrabble Score (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(let ((points "1332142418513113:11114484:"))
  (defun score (word) (seq-reduce
    (lambda (a c) (+ a (- (aref points (- c ?a)) ?0)))
    (downcase word) 0)))

(provide 'scrabble-score)
;;; scrabble-score.el ends here