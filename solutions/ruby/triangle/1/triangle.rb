# Eternal gratitude to Shree DR.MDD

class Triangle
  attr_reader :eq_type, :iso_type, :sca_type
  alias equilateral? eq_type
  alias isosceles? iso_type
  alias scalene? sca_type

  def initialize(edges)
    @eq_type = valid_shape?(edges) && edges.uniq.size == 1
    @iso_type = valid_shape?(edges) && edges.uniq.size <= 2
    @sca_type = valid_shape?(edges) && edges.uniq.size == 3
  end

  private

  def valid_shape?(edges)
    (largest, *rest) = edges.sort.reverse
    edges.all?(&:positive?) && rest.sum > largest
  end
end

module BookKeeping
  VERSION = 1
end
