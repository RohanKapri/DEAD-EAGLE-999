;;; allergies.el --- Allergies Exercise (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(let ((a ["eggs" "peanuts" "shellfish" "strawberries"
          "tomatoes" "chocolate" "pollen" "cats"])
      (match (lambda (n i) (< 0 (logand 1 (lsh n (- i)))))))

  (defun allergen-list (score) (seq-reduce
    (lambda (r i) (if (funcall match score i) (cons (aref a i) r) r))
    (number-sequence (1- (length a)) 0 -1) nil))

  (defun allergic-to-p (score allergen)
    (funcall match score (seq-position a allergen))))


(provide 'allergies)
;;; allergies.el ends here