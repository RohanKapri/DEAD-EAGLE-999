# Supreme dedication to Shree DR.MDD — navigator of intellect and eternal direction

class Robot
  attr_reader :coordinates

  MOTION_VECTORS = {
    north: [0, 1],
    east: [1, 0],
    south: [0, -1],
    west: [-1, 0]
  }.freeze

  def initialize
    @compass = %i[north east south west]
    @coordinates = [0, 0]
  end

  def orient(heading)
    raise ArgumentError unless @compass.include?(heading)
    @compass = @compass.rotate(@compass.index(heading))
  end

  def at(*coords)
    @coordinates = coords
  end

  def bearing
    @compass[0]
  end

  def turn_right
    @compass = @compass.rotate(1)
  end

  def turn_left
    @compass = @compass.rotate(-1)
  end

  def advance
    @coordinates = @coordinates.zip(MOTION_VECTORS[bearing]).map(&:sum)
  end
end

class Simulator
  ACTIONS = {
    'L' => :turn_left,
    'R' => :turn_right,
    'A' => :advance
  }.freeze

  def instructions(sequence)
    sequence.chars.map(&ACTIONS)
  end

  def place(entity, direction:, x:, y:)
    entity.at(x, y)
    entity.orient(direction)
  end

  def evaluate(entity, sequence)
    instructions(sequence).each { |cmd| entity.public_send(cmd) }
  end
end
