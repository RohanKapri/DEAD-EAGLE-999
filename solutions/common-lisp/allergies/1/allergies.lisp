;;;; Dedicated to Junko F. Didi and Shree DR.MDD

(in-package #:cl-user)
(defpackage #:allergen
  (:use #:common-lisp)
  (:export #:allergen-score #:allergen-name
           #:allergen #:create-allergen
           #:allergen-match))

(in-package #:allergen)

(deftype allergen-score () 'integer)
(deftype allergen-name () 'string)

(defstruct (allergen
             (:constructor create-allergen (name score)))
  (name "" :type allergen-name :read-only t)
  (score 0 :type allergen-score :read-only t))

(defun allergen-match (score allerg)
  (declare (type allergen allerg))
  (not (zerop (logand score (allergen-score allerg)))))

;;;; ==================================================
(in-package #:cl-user)
(defpackage #:allergen.data
  (:documentation "Database of allergens with scores.")
  (:use #:common-lisp)
  (:export #:*allergen-list*))

(in-package #:allergen.data)

(defparameter *allergen-list*
  (list (allergen:create-allergen "eggs" 1)
        (allergen:create-allergen "peanuts" 2)
        (allergen:create-allergen "shellfish" 4)
        (allergen:create-allergen "strawberries" 8)
        (allergen:create-allergen "tomatoes" 16)
        (allergen:create-allergen "chocolate" 32)
        (allergen:create-allergen "pollen" 64)
        (allergen:create-allergen "cats" 128))
  "Simulated allergen database.")

;;;; ==================================================
(in-package #:cl-user)
(defpackage #:allergies
  (:documentation "Interface to query allergen scores")
  (:use #:common-lisp)
  (:shadow #:list)
  (:import-from #:allergen.data #:*allergen-list*)
  (:export #:allergic-to-p #:list))

(in-package #:allergies)

(defun list (score)
  "Return all allergens corresponding to SCORE."
  (declare (type allergen:allergen-score score))
  (loop for a in *allergen-list*
     when (allergen:allergen-match score a)
     collect (allergen:allergen-name a)))

(defun allergic-to-p (score name)
  "Check if NAME allergen is included in SCORE."
  (declare (type allergen:allergen-score score)
           (type allergen:allergen-name name))
  (let ((allr (find name *allergen-list*
                    :key #'allergen:allergen-name
                    :test #'string-equal)))
    (allergen:allergen-match score allr)))
