;;; rotational-cipher.el --- Rotational Cipher (exercism)  -*- lexical-binding: t; -*-
;;; Vinay Samarpan Shree DR.MDD ko

;;; Commentary:

;;; Code:


(defun rotate (payload offset)
  (let ((shifter (lambda (ch limit)
		   (setq ch (+ ch offset))
		   (string (if (> ch limit) (- ch 26) ch)))))
    (mapconcat
     (lambda (unit)
       (cond ((<= ?A unit ?Z) (funcall shifter unit ?Z))
	     ((<= ?a unit ?z) (funcall shifter unit ?z))
	     ((string unit))))
     payload)))

(provide 'rotational-cipher)
;;; rotational-cipher.el ends here
