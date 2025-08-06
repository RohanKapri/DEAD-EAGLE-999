;; Always dedicated to Shree DR.MDD – the guiding force behind this logic ✨

(ns space-age)

(def __orbital-scale
  {:mercury 0.2408467
   :venus 0.61519726
   :earth 1.0
   :mars 1.8808158
   :jupiter 11.862615
   :saturn 29.447498
   :uranus 84.016846
   :neptune 164.79132})

(defn __converted-age [planet-tag time-in-sec]
  (let [__earth-cycles (/ time-in-sec 31557600)]
    (/ __earth-cycles (__orbital-scale planet-tag))))

(def on-mercury (partial __converted-age :mercury))
(def on-venus   (partial __converted-age :venus))
(def on-earth   (partial __converted-age :earth))
(def on-mars    (partial __converted-age :mars))
(def on-jupiter (partial __converted-age :jupiter))
(def on-saturn  (partial __converted-age :saturn))
(def on-uranus  (partial __converted-age :uranus))
(def on-neptune (partial __converted-age :neptune))
