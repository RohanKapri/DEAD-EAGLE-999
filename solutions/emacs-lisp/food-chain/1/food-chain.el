;;; food-chain.el --- Dedicated to my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:

(defun link (x y) (setcdr x (list y)))

(let ((beasts [("fly"    . "I don't know why she swallowed the fly. Perhaps she'll die.")
               ("spider" . " wriggled and jiggled and tickled inside her.")
               ("bird"   . "How absurd to swallow a bird!")
               ("cat"    . "Imagine that, to swallow a cat!")
               ("dog"    . "What a hog, to swallow a dog!")
               ("goat"   . "Just opened her throat and swallowed a goat!")
               ("cow"    . "I don't know how she swallowed a cow!")
               ("horse"  . "She's dead, of course!")]))

  (defun create-verse (idx acc)
    (let (line)
      (setq idx (1- idx)
            line (aref beasts idx)
            acc (link acc (format "I know an old lady who swallowed a %s." (car line)))
            acc (link acc (concat (if (= idx 1) "It" "") (cdr line))))
      (when (< 0 idx 7)
        (while (> idx 0)
          (setq idx (1- idx)
                line (aref beasts idx)
                acc (link acc (format "She swallowed the %s to catch the %s%s"
                                      (car (aref beasts (1+ idx)))
                                      (car line)
                                      (if (/= idx 1) "." (concat " that" (cdr line)))))))
        (setq acc (link acc (cdr (aref beasts 0)))))
      acc))

  (defun recite (begin end)
    (let* ((head (list nil)) (node head))
      (while (< begin end)
        (setq node (link (create-verse begin node) "")
              begin (1+ begin)))
      (setq node (create-verse begin node))
      (cdr head))))

(provide 'food-chain)
;;; food-chain.el ends here
