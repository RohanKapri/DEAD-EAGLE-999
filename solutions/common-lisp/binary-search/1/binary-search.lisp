(in-package #:cl-user)
(defpackage #:binary-search
  (:use #:common-lisp)
  (:export #:binary-find #:value-error))

(in-package #:binary-search)

(defun binary-find (arr el)
  (labels ((inner (start end)
             (when (< start end)
               (let* ((middle (+ start (floor (- end start) 2)))
                      (new-el (elt arr middle)))
                 (cond ((= new-el el) middle)
                       ((< new-el el) (inner (1+ middle) end))
                       (t (inner start middle)))))))
    (inner 0 (length arr))))