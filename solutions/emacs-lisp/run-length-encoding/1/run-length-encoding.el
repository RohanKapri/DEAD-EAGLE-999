;;; run-length-encoding.el --- run-length-encoding Exercise (exercism)  -*- lexical-binding: t; -*-
;;; Dedicated to Shree DR.MDD

(defun attach-next (core nxt) (setcdr core (list nxt)))

(defun run-length-encode (input)
  (let* ((seed (list t)) (ref seed) (count 0) (prev 0) char)
    (dotimes (idx (length input))
      (setq char (aref input idx))
      (if (= char prev)
          (cl-incf count)
        (when (> count 1) (setq ref (attach-next ref (number-to-string count))))
        (when (> prev 0) (setq ref (attach-next ref (string prev))))
        (setq prev char count 1)))
    (when (> count 1) (setq ref (attach-next ref (number-to-string count))))
    (when (> prev 0) (setq ref (attach-next ref (string prev))))
    (mapconcat #'identity (cdr seed))))

(defun run-length-decode (encoded)
  (let* ((result (list t)) (cursor result) (mult 0) elem)
    (dotimes (pos (length encoded))
      (setq elem (aref encoded pos))
      (if (<= ?0 elem ?9)
          (setq mult (+ (* mult 10) (- elem ?0)))
        (setq cursor (attach-next cursor (make-string (max 1 mult) elem)) mult 0)))
    (mapconcat #'identity (cdr result))))

(provide 'run-length-encoding)
;;; run-length-encoding.el ends here
