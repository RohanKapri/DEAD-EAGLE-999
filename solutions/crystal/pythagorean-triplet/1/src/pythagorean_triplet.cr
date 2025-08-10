module PythagoreanTriplet
  def self.triplets_with_sum(sum : Int32) : Array(Array(Int32))
    triplets = [] of Array(Int32)

    # Loop over possible values for a and b using the .each iterator
    1.upto(sum - 1) do |a|
      (a + 1).upto(sum - a - 1) do |b|
        c = sum - a - b

        # Check if a, b, c form a Pythagorean triplet
        if a * a + b * b == c * c
          triplets << [a, b, c]
        end
      end
    end

    triplets
  end
end