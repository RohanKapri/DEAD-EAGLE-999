;;; meetup.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(require 'calendar)

(defun __wday-slot (label)
  (setq label (capitalize (substring (symbol-name label) 1)))
  (let ((count 0))
    (while (not (string= label (calendar-day-name (list 1 (+ count 4) 1970))))
      (setq count (1+ count)))
    count))

(defun meetup (yr mon wday phase)
  (let ((anchor (pcase phase
                  (:first 7) (:second 14) (:teenth 19) (:third 21)
                  (:fourth 28)
                  (:last (calendar-last-day-of-month mon yr)))))
    (pcase (calendar-gregorian-from-absolute
            (calendar-dayname-on-or-before
             (__wday-slot wday)
             (calendar-absolute-from-gregorian (list mon anchor yr))))
      (`(,m ,d ,y) (list y m d)))))

(provide 'meetup)
;;; meetup.el ends here
