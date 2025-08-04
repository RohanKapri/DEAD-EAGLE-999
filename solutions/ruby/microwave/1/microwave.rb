class Microwave
  attr_reader :timer

  def initialize time
    hours = time / 100
    minutes = time % 100

    if minutes > 59
      hours += 1
      minutes -= 60
    end

    @timer = "%02d:%02d" % [hours, minutes]
  end
end