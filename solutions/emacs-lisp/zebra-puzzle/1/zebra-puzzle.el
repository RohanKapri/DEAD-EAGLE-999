;;; zebra-puzzle.el --- Zebra Puzzle (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:
(defconst houses '((yellow Norwegian  fox    water        kools)
		           (blue   Ukrainian  horse  tea          chesterfields)
		           (red    Englishman snails milk         old_gold)
		           (green  Japanese   zebra  coffee       parliaments)
		           (ivory  Spaniard   dog    orange_juice lucky_strike)))

(defun find(idx target)
  (symbol-name (cadr (car (seq-filter (lambda (house)
					(eq target (nth idx house)))
				      houses)))))

(defun drinks-water ()
  (find 3 'water))

(defun owns-zebra ()
  (find 2 'zebra))
(provide 'zebra-puzzle)
;;; zebra-puzzle.el ends here
