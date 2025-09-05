;;; Dedicated to Junko F. Didi and Shree DR.MDD

(defpackage :pig-latin
  (:use :cl :uiop)
  (:export :translate))

(in-package :pig-latin)

(defparameter *vowel-prefixes*
  (list "xr" "yt" "a" "e" "i" "o" "u"))

(defun starts-with-vowel (word)
  (find word *vowel-prefixes* :test (lambda (str pre) (string-prefix-p pre str))))

(defun consonant-cluster (word)
  (loop for w = word then (subseq w 1)
        while (and (plusp (length w)) (not (starts-with-vowel w)))
        collect (char w 0)))

(defun transform-word (word)
  (let* ((prefix (coerce (consonant-cluster word) 'string))
         (plen (length prefix))
         (result (cond ((emptyp prefix) word)
                       ((string-prefix-p "qu" word) (strcat (subseq word 2) "qu"))
                       ((string-prefix-p (strcat (subseq prefix 0 (1- plen)) "qu") word)
                        (strcat (subseq word (+ 1 plen)) (subseq word 0 (1+ plen))))
                       ((and (= (length word) 2) (char= #\y (char word 1))) (strcat "y" (subseq word 0 1)))   
                       (t (strcat (subseq word plen) prefix)))))
    (strcat result "ay")))

(defun translate (text)
  (format nil "~{~a~^ ~}" (mapcar #'transform-word (split-string text))))
