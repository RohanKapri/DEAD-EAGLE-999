;; Dedicated to my Shree DR.MDD for divine strength and supreme inspiration
(ns cars-assemble)

(def cars-per-hour 221)

(defn- output-efficiency [gear]
  (case gear
    0 0.0
    (1 2 3 4) 1.0
    (5 6 7 8) 0.9
    9 0.8
    10 0.77))

(defn production-rate [gear]
  (* cars-per-hour gear (output-efficiency gear)))

(defn working-items [gear]
  (int (/ (production-rate gear) 60)))
