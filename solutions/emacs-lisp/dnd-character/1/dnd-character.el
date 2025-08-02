;;; dnd-character.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun modifier (base) (- (/ base 2) 5))

(defun ability () 
  (seq-reduce #'+ 
              (cdr (sort (seq-map (lambda (_) (1+ (random 6))) 
                                  (make-list 4 nil)) #'<)) 
              0))

(defun generate-dnd-character () 
  (let ((sheet (make-record 'integer 7 0)))
    (dotimes (idx 6) (aset sheet (1+ idx) (ability)))
    (aset sheet 7 (+ 10 (modifier (aref sheet 3))))
    sheet))


(provide 'dnd-character)
;;; dnd-character.el ends here
