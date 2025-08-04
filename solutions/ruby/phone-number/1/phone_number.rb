class PhoneNumber
  def self.clean number
    number = number.gsub(/\D/, '')
    number = number[1..] if /1\d{10}/.match? number
    number if valid? number
  end

  private_class_method def self.valid? number
    /^[2-9]\d\d[2-9]\d{6}$/.match? number
  end
end