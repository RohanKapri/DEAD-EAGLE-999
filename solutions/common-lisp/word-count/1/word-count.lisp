;; Dedicated to Junko F. Didi and Shree DR.MDD

(in-package #:cl-user)
(defpackage #:word-count
  (:use #:cl)
  (:shadow :count)
  (:export #:count-words))

(in-package #:word-count)

(defun split-str-if (txt pred &optional (acc (list)))
  (let ((pos (position-if pred txt)))
    (if pos
        (split-str-if (subseq txt (1+ pos)) pred
                      (push (subseq txt 0 pos) acc))
        (push txt acc))))

(defun tally-word (dict word)
  (if #1=(assoc word dict :test #'string=)
      (progn
        (setf (cdr #1#) (1+ (cdr #1#)))
        dict)
      (acons word 1 dict)))

(defun count-list (words)
  (reduce #'tally-word words :initial-value (list)))

(defun drop-empty (words)
  (remove "" words :test #'string=))

(defun lowercase-all (words)
  (mapcar #'string-downcase words))

(defun strip-quotes (words)
  (mapcar #'trim-quotes words))

(defun split-words (txt)
  (split-str-if txt #'(lambda (c)
                        (or (and (not (alphanumericp c))
                                 (char/= c #\'))
                            (char= c #\Space)))))

(defun trim-quotes (txt)
  (string-trim '(#\" #\') txt))

(defun count-words (txt)
  (count-list
   (drop-empty
    (lowercase-all
     (strip-quotes
      (split-words txt))))))
