;;; parallel-letter-frequency.el --- Parallel Letter Frequency (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun async-freq (a n cb)
  (let ((d (make-hash-table)) (m (make-mutex)))
    (setq a (seq-split a (max 1 (ceiling (length a) n))))
    (dotimes (i n) (make-process
      :name (format "freq-%d" i)
      :buffer (generate-new-buffer (format "*freq-%d*" i))
      :command (list "emacs" "--batch" "-Q" "--eval" (format
	"(let ((h (make-hash-table)) c)
	   (dolist (s '%S)
	     (setq s (downcase
	       (replace-regexp-in-string \"[^[:alpha:]]+\" \"\" s)))
	     (dotimes (i (length s))
	       (setq c (aref s i)) (puthash c (1+ (gethash c h 0)) h)))
	   (print h))" (nth i a)))
      :sentinel (lambda (p _) (when (eq 'exit (process-status p))
	(with-current-buffer (process-buffer p)
	  (goto-char (point-min))
	  (with-mutex m
	    (maphash (lambda (k v) (puthash k (+ v (gethash k d 0)) d))
		     (read (current-buffer)))
	    (cl-decf n) (when (zerop n) (funcall cb d)))
	  (kill-buffer (current-buffer)))))))))

(defun calculate-frequencies (texts) (let ((pending t) d)
  (async-freq texts 4 (lambda (r) (setq d r pending nil)))
  (while pending (sleep-for 0.1)) d))


(provide 'parallel-letter-frequency)
;;; parallel-letter-frequency.el ends here
