(defpackage :key-comparison
  (:use :cl)
  (:export
   :key-object-identity
   :key-numbers
   :key-numbers-of-different-types
   :key-characters
   :key-characters-case-insensitively
   :key-strings
   :key-strings-case-insensitively
   :key-conses-of-symbols
   :key-conses-of-characters
   :key-conses-of-numbers
   :key-conses-of-characters-case-insensitively
   :key-conses-of-numbers-of-different-types
   :key-arrays
   :key-arrays-loosely))
(in-package :key-comparison)

(eval-when (:compile-toplevel :load-toplevel :execute)
  (dolist (definition `((key-object-identity . ,#'eq)
                        (key-numbers . ,#'eql)
                        (key-numbers-of-different-types . ,#'=)
                        (key-characters . ,#'char=)
                        (key-characters-case-insensitively . ,#'equalp)
                        (key-strings . ,#'string=)
                        (key-strings-case-insensitively . ,#'equalp)
                        (key-conses-of-symbols . ,#'equal)
                        (key-conses-of-characters . ,#'equal)
                        (key-conses-of-numbers . ,#'equal)
                        (key-conses-of-characters-case-insensitively . ,#'equalp)
                        (key-conses-of-numbers-of-different-types . ,#'equalp)
                        (key-arrays . ,#'eql)
                        (key-arrays-loosely . ,#'equalp)))
    (setf (symbol-function (car definition)) (cdr definition))))