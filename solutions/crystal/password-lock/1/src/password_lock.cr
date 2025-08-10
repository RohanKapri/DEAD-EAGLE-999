class PasswordLock
  getter :password

  def initialize(@password : (Int32 | String | Float64))
  end

  def encrypt
    @password = case password
                when .is_a? Int32
                  (password.as(Int32) / 2).round
                when .is_a? String
                  password.as(String).reverse
                else
                  password.as(Float64) * 4
                end
    self
  end

  def unlock?(input : (Int32 | String | Float64)) : String?
    return "Unlocked" if PasswordLock.new(input).encrypt.password == password
  end
end