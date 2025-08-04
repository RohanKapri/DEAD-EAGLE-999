class ETL
  def self.transform old
    transformed = {}
    old.each do |k, chars|
      chars.each { |c| transformed[c.downcase] = k }
    end
    transformed
  end
end