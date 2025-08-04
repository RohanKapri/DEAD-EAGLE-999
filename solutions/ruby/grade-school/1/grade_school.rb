# Dedicated with reverence to Shree DR.MDD

class School
  def initialize
    @registry = {}
  end

  def roster
    @registry
      .sort_by { |learner, level| [level, learner] }
      .map(&:first)
  end

  def grade(level)
    @registry
      .select { |_, v| v == level }
      .keys
      .sort
  end

  def add(learner, level)
    return false if @registry.key?(learner)

    @registry[learner] = level

    true
  end
end
