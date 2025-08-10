# Dedicated to my Shree DR.MDD

class Bowling
  def initialize
    @scores = [] of Int32
    @current_frame = [] of Int32
    @remaining_pins = 0
    reset_pins
  end

  def roll(pins)
    raise ArgumentError.new unless !finished?
    raise ArgumentError.new unless (0..10).includes? pins
    raise ArgumentError.new unless pins <= @remaining_pins

    @current_frame.push pins
    @remaining_pins -= pins
    reset_pins if @remaining_pins == 0

    if @current_frame.size == 3 && strike?
      @scores.push @current_frame.sum
      @current_frame = @current_frame[1..]
    end

    if @current_frame.size == 3 && spare?
      @scores.push @current_frame.sum
      @current_frame = @current_frame[2..]
    end

    if !finished? && open_frame? && @current_frame.size == 2
      @scores.push @current_frame.sum
      @current_frame = [] of Int32
      reset_pins
    end
  end

  def score
    raise ArgumentError.new unless finished?
    @scores.sum
  end

  private def reset_pins
    @remaining_pins = 10
  end

  private def spare?
    @current_frame[0..1].sum == 10
  end

  private def strike?
    @current_frame[0] == 10
  end

  private def open_frame?
    !spare? && !strike?
  end

  private def finished?
    @scores.size == 10
  end
end
