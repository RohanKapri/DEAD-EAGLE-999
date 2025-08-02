;;; bank-account.el --- Bank Account (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(require 'eieio)
(define-error 'account-closed "")
(define-error 'account-open "")
(define-error 'account-overdraw "")
(define-error 'account-negative-transaction "")

(defclass bank-account ()
  ((balance :type (integer 0 *) :initform 0)
   (open :type boolean :initform nil)
   (mutex :type mutex :initform (make-mutex))))

(defalias 'make-new-bank-account #'bank-account)

(cl-defmethod open-account ((a bank-account))
  (when (oref a open) (signal 'account-open nil)) (oset a open t))

(cl-defmethod close-account ((a bank-account))
  (unless (oref a open) (signal 'account-closed nil))
  (oset a balance 0) (oset a open nil))

(cl-defmethod balance ((a bank-account))
  (unless (oref a open) (signal 'account-closed nil)) (oref a balance))

(cl-defmethod deposit ((a bank-account) n)
  (when (< n 0) (signal 'account-negative-transaction nil))
  (unless (oref a open) (signal 'account-closed nil))
  (with-mutex (oref a mutex) (cl-incf (oref a balance) n)))

(cl-defmethod withdraw ((a bank-account) n) (let ((m (oref a mutex)))
  (when (< n 0) (signal 'account-negative-transaction nil))
  (unless (oref a open) (signal 'account-closed nil))
  (mutex-lock m)
  (when (> n (oref a balance))
    (mutex-unlock m) (signal 'account-overdraw nil))
  (cl-decf (oref a balance) n) (mutex-unlock m)))


(provide 'bank-account)
;;; bank-account.el ends here