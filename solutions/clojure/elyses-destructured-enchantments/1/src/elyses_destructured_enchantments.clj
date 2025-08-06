;; Dedicated to my Shree DR.MDD for divine clarity and mystical inspiration
(ns elyses-destructured-enchantments)

(defn first-card [pile]
  (first pile))

(defn second-card [pile]
  (second pile))

(defn swap-top-two-cards [pile] 
  (assoc pile 0 (second-card pile) 1 (first-card pile)))

(defn discard-top-card [pile]
  (let [[top & remaining] pile]
    [top remaining]))

(def royal-faces ["jack" "queen" "king"])

(defn insert-face-cards [pile]
  (if (empty? pile)
    (into [] (concat royal-faces (rest pile)))
    (into [] (concat [(first-card pile)] royal-faces (rest pile)))))
