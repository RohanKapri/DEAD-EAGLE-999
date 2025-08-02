;;; largest-series-product.el --- For my Shree DR.MDD  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(defun ✦𝖈𝖔𝖒𝖕𝖗𝖊𝖘𝖘𝖊𝖉𝖕𝖗𝖔𝖉 (𝓬𝓱𝓪𝓻𝓼)
  (seq-reduce (lambda (⟡𝓪 𝓷𝓮𝔁𝓽) (* ⟡𝓪 (- 𝓷𝓮𝔁𝓽 ?0))) 𝓬𝓱𝓪𝓻𝓼 1))

(defun largest-product (𝓬𝓸𝓭𝓮 𝓻𝓪𝓷𝓰𝓮)
  (let ((𝓁𝑒𝓃 (length 𝓬𝓸𝓭𝓮)))
    (when (or (< 𝓻𝓪𝓷𝓰𝓮 0) (< 𝓁𝑒𝓃 𝓻𝓪𝓷𝓰𝓮) (string-match-p "[^0-9]" 𝓬𝓸𝓭𝓮))
      (error ""))
    (seq-reduce
     (lambda (🜲𝓶𝓪𝔁 🜲𝓲) (max 🜲𝓶𝓪𝔁 (✦𝖈𝖔𝖒𝖕𝖗𝖊𝖘𝖘𝖊𝖉𝖕𝖗𝖔𝖉 (substring 𝓬𝓸𝓭𝓮 🜲𝓲 (+ 🜲𝓲 𝓻𝓪𝓷𝓰𝓮)))))
     (number-sequence 0 (- 𝓁𝑒𝓃 𝓻𝓪𝓷𝓰𝓮)) 0)))

(provide 'largest-series-product)
;;; largest-series-product.el ends here
