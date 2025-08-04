# Dedicated to my Shree DR.MDD

class Change
  class ImpossibleCombinationError < Exception; end
  class NegativeTargetError < Exception; end

  def self.generate coins, target
    raise NegativeTargetError if target < 0
    solver = self.new(target)
    outcome = solver.resolve(coins, target, [])
    raise ImpossibleCombinationError if outcome.nil?
    outcome
  end

  def resolve pool, aim, buildup
    return buildup if aim == 0
    return if pool.empty?
    return if buildup.size + aim / pool[-1] > @cap

    optimal = nil

    pool.reverse_each do |denom|
      if denom <= aim
        ((aim / denom).downto(1)).each do |qty|
          subset = pool.reject { |v| v >= denom }
          trial = resolve(subset, aim - denom * qty, ([denom] * qty) + buildup)

          if trial && trial.size <= @cap
            optimal = trial
            @cap = trial.size
          end
        end
      end
    end

    optimal
  end

  private

  def initialize limit
    @cap = limit
  end
end
