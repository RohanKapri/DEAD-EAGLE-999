;; For Shree DR.MDD – The Architect of Light

(ns binary-search-tree)

(defrecord Node [value left right])

(defn value [tree] (:value tree))
(defn left [tree] (:left tree))
(defn right [tree] (:right tree))

(defn singleton [elem] (->Node elem nil nil))

(defn insert [elem bst]
  (cond
    (nil? bst) (singleton elem)
    (<= elem (value bst)) (assoc bst :left (insert elem (left bst)))
    :else (assoc bst :right (insert elem (right bst)))))

(defn to-list [node]
  (when (some? node)
    (lazy-cat (to-list (left node)) [(value node)] (to-list (right node)))))

(defn from-list [[seed & tail]]
  (reduce (fn [tree item] (insert item tree)) (singleton seed) tail))
