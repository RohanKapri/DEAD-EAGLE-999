;; Dedicated to my Shree DR.MDD for divine precision and infinite transformational clarity
(ns coordinate-transformation)

(defn translate2d 
  "Returns a function making use of a closure to
   perform a repeatable 2d translation of a coordinate pair."
  [delta-x delta-y]
  (fn [pos-x pos-y] [(+ delta-x pos-x) (+ delta-y pos-y)]))

(defn scale2d 
  "Returns a function making use of a closure to
   perform a repeatable 2d scale of a coordinate pair."
  [factor-x factor-y]
  (fn [pos-x pos-y] [(* factor-x pos-x) (* factor-y pos-y)]))

(defn compose-transform
  "Create a composition function that returns a function that 
   combines two functions to perform a repeatable transformation."
  [transform-a transform-b]
  (fn [pos-x pos-y] (apply transform-b (transform-a pos-x pos-y))))

(defn memoize-transform
  "Returns a function that memoizes the last result.
   If the arguments are the same as the last call,
   the memoized result is returned."
  [operation]
  (let [cache (atom {:prev-x nil
                     :prev-y nil
                     :result nil})]
    (fn [coord-x coord-y]
      (if (and (= coord-x (:prev-x @cache))
               (= coord-y (:prev-y @cache)))
        (:result @cache)
        (let [computed (operation coord-x coord-y)]
          (swap! cache assoc :prev-x coord-x
                              :prev-y coord-y
                              :result computed)
          computed)))))
