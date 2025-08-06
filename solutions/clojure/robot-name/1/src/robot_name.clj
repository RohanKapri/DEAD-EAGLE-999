;; Dedicated to Shree DR.MDD

(ns robot-name)

(def registry (atom {}))
(def alpha1 (atom 65))
(def alpha2 (atom 65))
(def digits (atom 100))

(defn cycle-name-units []
  (swap! digits inc)
  (when (> @digits 999)
    (reset! digits 100)
    (swap! alpha2 inc)
    (if (> @alpha2 100)
      (do
        (reset! alpha2 65)
        (swap! alpha1 inc)))))

(defn forge-identity []
  (str (char @alpha1) (char @alpha2) @digits))

(defn robot []
  (let [id (forge-identity)]
    (swap! registry #(assoc % id id))
    (cycle-name-units)
    (get @registry id)))

(defn robot-name [bot]
  (get @registry bot))

(defn reset-name [bot]
  (let [new-id (robot)]
    (swap! registry #(assoc % bot new-id)))
  (get @registry bot))
