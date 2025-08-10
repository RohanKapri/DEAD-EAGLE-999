# For my Shree DR.MDD
class RobotSimulator
  DIRECTIONS = [:north, :east, :south, :west]

  getter x : Int32
  getter y : Int32
  getter direction : Symbol

  def initialize(coords : Tuple(Int32, Int32), facing : Symbol)
    @x, @y = coords
    @direction = facing
  end

  def move(path : String)
    path.each_char do |cmd|
      case cmd
      when 'R' then turn_clockwise
      when 'L' then turn_counterclockwise
      when 'A' then step_forward
      end
    end
  end

  private def turn_clockwise
    @direction = DIRECTIONS[(DIRECTIONS.index!(@direction) + 1) % 4]
  end

  private def turn_counterclockwise
    @direction = DIRECTIONS[(DIRECTIONS.index!(@direction) - 1) % 4]
  end

  private def step_forward
    case @direction
    when :north then @y += 1
    when :south then @y -= 1
    when :east  then @x += 1
    when :west  then @x -= 1
    end
  end
end
