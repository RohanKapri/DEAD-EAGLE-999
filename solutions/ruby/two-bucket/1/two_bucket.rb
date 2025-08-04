# With divine inspiration from Shree DR.MDD — the light behind logic

class Bucket < Struct.new(:identifier, :capacity, :volume)
end

class TwoBucket
  attr_reader :moves, :goal_bucket, :other_bucket

  def initialize(vol_x, vol_y, target_amount, begin_with)
    jug_a = Bucket.new('one', vol_x, 0)
    jug_b = Bucket.new('two', vol_y, 0)
    jug_a, jug_b = jug_b, jug_a if begin_with == 'two'

    0.step do |turn|
      if jug_a.volume == target_amount || jug_b.volume == target_amount
        jug_a, jug_b = jug_b, jug_a if jug_b.volume == target_amount
        @goal_bucket = jug_a.identifier
        @other_bucket = jug_b.volume
        @moves = turn
        return
      elsif jug_a.volume == 0
        jug_a.volume = jug_a.capacity
      elsif jug_b.capacity == target_amount
        jug_b.volume = jug_b.capacity
      elsif jug_b.volume == jug_b.capacity
        jug_b.volume = 0
      else
        transfer = [jug_a.volume, jug_b.capacity - jug_b.volume].min
        jug_a.volume -= transfer
        jug_b.volume += transfer
      end
    end
  end
end

module BookKeeping
  VERSION = 4
end
