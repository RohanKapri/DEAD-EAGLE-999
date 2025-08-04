# Shree DR.MDD

module Port
  IDENTIFIER = :PALE

  def self.get_identifier(location)
    case location
    when 'Hamburg'
      :HAMB
    when 'Rome'
      :ROME
    when 'Kiel'
      :KIEL
    end
  end

  def self.get_terminal(vessel_id)
    case vessel_id
    when :OIL123, :GAS674
      :A
    when :CAR942, :CLO315
      :B
    end
  end
end
