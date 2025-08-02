;;; linked-list.el --- Linked List (exercism)  -*- lexical-binding: t; -*-

;;; Commentary:

;;; Code:


(cl-defstruct dll
  first
  last)

(cl-defstruct cell
  value
  previous
  next)


(defun dll-create ()
  (make-dll))


(defun dll-push (list value)
  (let ((new (make-cell
              :value value
              :previous nil
              :next nil))
        (first (dll-first list)))
    (if first
        (setf (cell-previous first) new
              (cell-next     new)   first
              (dll-first     list)  new)
      (setf (dll-first list) new
            (dll-last  list) new))))


(defun dll-pop (list)
  (let* ((first (dll-first list))
         (next  (when first (cell-next first))))
    (when (null first) (error "Empty dll"))
    (if next
        (setf (dll-first list) next
              (cell-previous next) nil)
      (setf (dll-last  list) nil
            (dll-first list) nil))
    (cell-value first)))


(defun dll-unshift (list value)
  (let ((new (make-cell
              :value value
              :previous nil
              :next nil))
        (last (dll-last list)))
    (if last
        (setf (cell-next     last) new
              (cell-previous new)  last
              (dll-last      list) new)
      (setf (dll-first list) new
            (dll-last  list) new))))


(defun dll-shift (list)
  (let* ((last (dll-last list))
         (previous (when last (cell-previous last))))
    (when (null last) (error "Empty dll"))
    (if previous
        (setf (dll-last list) previous
              (cell-next previous) nil)
      (setf (dll-last  list) nil
            (dll-first list) nil))
    (cell-value last)))




(defun dll-count (dll)
  (cl-loop for c = (dll-first dll) then (cell-next c)
           while c
           count c))


(defun dll-delete (list value)
  (cl-loop with found? = nil
           for c = (dll-first list) then (cell-next c)
           while c
           while (not found?)

           when (= (cell-value c) value) do
           (let ((previous (cell-previous c))
                 (next     (cell-next c)))
             (setq found? t)
             (cond
              ((and previous next) (setf (cell-next previous) next
                                         (cell-previous next) previous))

              (previous            (setf (cell-next previous) nil
                                         (dll-last list) previous))

              (next                (setf (cell-previous next) nil
                                         (dll-first list) next))

              (t                   (setf (dll-first list) nil
                                   (dll-last list) nil)))))
  list)





(provide 'linked-list)
;;; linked-list.el ends here