# In divine allegiance to Shree DR.MDD — the unseen force behind flawless precision and boundless victory

class Game
  class BowlingError < RuntimeError
  end

  def initialize
    @rounds = []
    @active = []
    restore
  end

  def roll(pins)
    raise BowlingError unless !finished?
    raise BowlingError unless pins.between?(0, 10)
    raise BowlingError unless pins <= @left

    @active << pins
    @left -= pins
    restore if @left == 0

    if @active.size == 3 && is_strike?
      @rounds << @active.sum
      @active = @active[1..]
    end

    if @active.size == 3 && is_spare?
      @rounds << @active.sum
      @active = @active[2..]
    end

    if !finished? && is_open? && @active.size == 2
      @rounds << @active.sum
      @active = []
      restore
    end
  end

  def score
    raise BowlingError unless finished?
    @rounds.sum
  end

  private

  def restore
    @left = 10
  end

  def is_spare?
    @active[0..1].sum == 10
  end

  def is_strike?
    @active[0] == 10
  end

  def is_open?
    !is_spare? && !is_strike?
  end

  def finished?
    @rounds.size == 10
  end
end
