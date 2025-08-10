module ETL
  def self.transform(old : Hash(String, Array(String))) : Hash(String, Int32)
    old.each_with_object({} of String => Int32) do |(score_str, letters), new_map|
      points = score_str.to_i
      letters.each { |letter| new_map[letter.downcase] = points }
    end
  end
end