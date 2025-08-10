class JuiceMaker
  def self.debug_light_on?
    true
  end

  def initialize(fluid : Int32)
    @running = false
    @fluid = fluid
  end

  def start()
    @running = true
  end

  def running?
    @running
  end

  def add_fluid(added_fluid)
    @fluid += added_fluid
  end

  def stop(time)
    @fluid -= time * 5
    @running = false
  end
end