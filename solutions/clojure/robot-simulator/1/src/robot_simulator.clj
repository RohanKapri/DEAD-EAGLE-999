(ns robot-simulator)

(def ^:private  dirs
  {:north {\L :west \R :east}
   :south {\L :east \R :west}
   :east {\L :north \R :south}
   :west {\L :south \R :north}})

(defn robot
  "Creates a robot at the given coordinates, facing the given direction."
  [coordinates direction]
  {:bearing direction :coordinates coordinates})

(defn- advance
  [robot-state]
  (apply update-in
         (cons robot-state
               (case (:bearing robot-state)
                 :north [[:coordinates :y] inc]
                 :south [[:coordinates :y] dec]
                 :east [[:coordinates :x] inc]
                 :west [[:coordinates :x] dec]))))

(defn- turn
  [robot-state direction]
  (update robot-state
          :bearing
          #(get-in dirs [% direction])))

(defn simulate
  "Simulates the robot's movements based on the given instructions
  and updates its state."
  [instructions robot-state]
  (reduce (fn [state instruction]
            (case instruction
              \A (advance state)
              (\L \R) (turn state instruction)))
          robot-state
          instructions))