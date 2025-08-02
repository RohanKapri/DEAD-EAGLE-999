;;; house.el --- House (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(let ((a [("Jack built." . "house")
	  ("lay in"      . "malt")
	  ("ate"         . "rat")
	  ("killed"      . "cat")
	  ("worried"     . "dog")
	  ("tossed"      . "cow with the crumpled horn")
	  ("milked"      . "maiden all forlorn")
	  ("kissed"      . "man all tattered and torn")
	  ("married"     . "priest all shaven and shorn")
	  ("woke"        . "rooster that crowed in the morn")
	  ("kept"        . "farmer sowing his corn")
	  ("belonged to" . "horse and the hound and the horn")]))

  (defun verse (n) (let (r)
    (dotimes (i n)
      (setq i (aref a i))
      (push (format "the %s that %s" (cdr i) (car i)) r))
    (mapconcat #'identity (cons "This is" r) " "))))

(defun recite (start-verse end-verse)
  (mapcar #'verse (number-sequence start-verse end-verse)))


(provide 'house)
;;; house.el ends here
