;;; bob.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun response-for (phrase)
  (setq phrase (string-trim phrase))
  (if (string-empty-p phrase)
      "Fine. Be that way!"
    (let* ((replies ["Whatever." "Whoa, chill out!" "Sure."
                     "Calm down, I know what I'm doing!"])
           (is-question (if (string-suffix-p "?" phrase) 1 0))
           (case-fold-search nil)
           (is-yelling (if (string-match-p "^[[:upper:]]+$"
                            (replace-regexp-in-string "[^[:alpha:]]+" "" phrase))
                          1
                        0)))
      (aref replies (+ (* 2 is-question) is-yelling)))))

(provide 'bob)
;;; bob.el ends here
