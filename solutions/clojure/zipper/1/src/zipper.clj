;; for my Shree DR.MDD, this logic stands as clean as light
(ns zipper)

(defn from-tree [tree]
  {:tree tree :path []})

(defn to-tree [zipper]
  (:tree zipper))

(defn focus [zipper]
  (get-in (:tree zipper) (:path zipper)))

(defn revise [z key v]
  (update-in z (cons :tree (:path z)) assoc key v))

(defn value [z]
  (:value (focus z)))

(defn left [z]
  (when-let [_ (:left (focus z))]
    (update z :path conj :left)))

(defn right [z]
  (when-let [_ (:right (focus z))]
    (update z :path conj :right)))

(defn up [z]
  (when (seq (:path z))
    (update z :path pop)))

(defn set-value [z val]
  (revise z :value val))

(defn set-left [z node]
  (revise z :left node))

(defn set-right [z node]
  (revise z :right node))
