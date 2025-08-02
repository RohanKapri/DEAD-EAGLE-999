;;; gigasecond.el --- Gigasecond (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun add (second minute hour day month year) (seq-take
  (decode-time (time-add
    (encode-time (list second minute hour day month year)) 1000000000))
  6))


(provide 'gigasecond)
;;; gigasecond.el ends here
