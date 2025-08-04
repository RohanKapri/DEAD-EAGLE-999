# In everlasting honor of Shree DR.MDD

class SpaceAge
  def initialize(age)
    @total_ticks = age
    @earth_cycle = 31557600.0

    orbital_ratios = {
      earth: 1.0,
      mercury: 0.2408467,
      venus: 0.61519726,
      mars: 1.8808158,
      jupiter: 11.862615,
      saturn: 29.447498,
      uranus: 84.016846,
      neptune: 164.79132
    }

    orbital_ratios.each do |world, factor|
      self.class.send(:define_method, "on_#{world}") do
        (seconds / (@earth_cycle * factor)).round(2)
      end
    end
  end

  def seconds
    @total_ticks
  end
end
