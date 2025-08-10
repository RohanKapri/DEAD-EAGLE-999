module PhoneNumber
  def self.clean(phrase : String) : String
    # Remove non-digit characters
    cleaned = phrase.gsub(/\D/, "")

    # Remove country code if present
    cleaned = cleaned.lstrip('1') if cleaned.starts_with?('1')

    # Validate the number
    unless cleaned.size == 10 && cleaned[0].in?('2'..'9') && cleaned[3].in?('2'..'9')
      raise ArgumentError.new("Invalid number")
    end

    cleaned
  end
end