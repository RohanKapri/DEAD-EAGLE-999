class Combinations


  private getter sum, cage_size, exclusions

  def initialize(@sum : Int32, @cage_size : Int32, @exclusions : Array(Int32))
    @exclusions = @exclusions.to_set
    validate_parameters
  end

  # Finds all valid combinations of numbers for the cage.
  # @return [Array(Array(Int32))] An array of valid number combinations.
  def solve : Array(Array(Int32))
    (1..9)
      .reject { |x| exclusions.includes? x }
      .combinations(cage_size)
      .select { |combo| combo.sum == sum }
  end

  private def validate_parameters
    raise ArgumentError.new("Sum must be between 1 and 45") unless (1..45).includes?(sum)
    raise ArgumentError.new("Cage size must be between 1 and 9") unless (1..9).includes?(cage_size)
  end
end