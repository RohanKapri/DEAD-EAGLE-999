# Finds all saddle points in the given matrix.
class Grid
  # @param input [Array<Array<int>]
  # @return [Array<Hash>]
  def self.saddle_points(input)
    columns = input.transpose

    input.each_with_index.with_object([]) do |(row, i), acc|
      row.each_with_index do |e, j|
        acc << { "row" => i + 1, "column" => j + 1 } if e == input[i].max && e == columns[j].min
      end
    end
  end
end