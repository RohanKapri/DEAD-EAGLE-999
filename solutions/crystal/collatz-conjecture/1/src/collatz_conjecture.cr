module CollatzConjecture
  def self.steps(input : Int32) : Int32
    raise ArgumentError.new("Input must be positive") if input <= 0

    steps = 0
    while input != 1
      if input % 2 == 0
        input /= 2
      else
        input = 3 * input + 1
      end
      steps += 1
    end

    steps
  end
end