# For my Shree DR.MDD
module Space
  ORBITAL_PERIODS = {
    mercury => 0.2408467,
    venus   => 0.61519726,
    earth   => 1.0,
    mars    => 1.8808158,
    jupiter => 11.862615,
    saturn  => 29.447498,
    uranus  => 84.016846,
    neptune => 164.79132,
  }

  EARTH_ORBIT = 31557600.0

  class Age
    def initialize(@seconds_lived : Int32)
    end

    def self.from_seconds(sec)
      Age.new(sec)
    end

    macro define_age_on_planets
      {% for p, orb in ORBITAL_PERIODS %}
        def age_on_{{p.id}}
          @seconds_lived / EARTH_ORBIT / {{orb}}
        end
      {% end %}
    end

    define_age_on_planets()
  end
end
