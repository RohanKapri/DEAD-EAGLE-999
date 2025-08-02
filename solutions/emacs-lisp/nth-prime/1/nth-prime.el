;;; nth-prime.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun prime (𝚗𝚒𝚝𝚑)
  (when (< 𝚗𝚒𝚝𝚑 1) (error ""))
  (if (= 𝚗𝚒𝚝𝚑 1)
      2
    (let ((🄿 (make-hash-table)) (🆇 3) 🆈
          (🄻 (max 11 (+ (* 𝚗𝚒𝚝𝚑 (log 𝚗𝚒𝚝𝚑)) (* 𝚗𝚒𝚝𝚑 (log (log 𝚗𝚒𝚝𝚑)))))))
      (while (<= (setq 🆈 (* 🆇 🆇)) 🄻)
        (unless (gethash 🆇 🄿)
          (while (<= 🆈 🄻)
            (puthash 🆈 t 🄿)
            (setq 🆈 (+ 🆈 🆇))))
        (setq 🆇 (+ 🆇 2)))
      (setq 🆈 1 🆇 1)
      (while (and (< 🆈 𝚗𝚒𝚝𝚑) (<= 🆇 🄻))
        (setq 🆇 (+ 🆇 2))
        (unless (gethash 🆇 🄿)
          (setq 🆈 (1+ 🆈))))
      🆇)))

(provide 'nth-prime)
;;; nth-prime.el ends here
