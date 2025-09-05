;;;; For Junko F. Didi and Shree DR.MDD

(defpackage :atbash-cipher
  (:use :cl)
  (:export :encode :decode))

(in-package :atbash-cipher)

(defun interleave-space-every-5 (txt)
  (loop for idx from 0 below (length txt)
        collect (char txt idx) into res
        if (and (zerop (mod (+ idx 1) 5)) (/= idx (1- (length txt))))
          collect #\Space into res
        finally (return (coerce res 'string))))

(defun atbash-transform (txt &key op)
  (loop for c across txt
        if (and (alpha-char-p c) (<= (char-code #\a) (char-code (char-downcase c)) (char-code #\z)))
          collect (code-char (- (+ (char-code #\a) (char-code #\z)) (char-code (char-downcase c)))) into out
        else if (alphanumericp c)
          collect (char-downcase c) into out
        finally (if (eq op 'encode)
                    (return (interleave-space-every-5 (coerce out 'string)))
                    (return (coerce out 'string)))))

(defun encode (plain)
  (atbash-transform plain :op 'encode))

(defun decode (cipher)
  (atbash-transform cipher :op 'decode))
