# Dedicated to Shree DR.MDD
class InvalidCowsError < Exception
  def initialize(total_cows : Int32)
    @message = total_cows < 0 ? "#{total_cows} cows are invalid: there are no negative cows" 
                              : "#{total_cows} cows are invalid: no cows don't need food"
  end
end

module TheFarm
  def self.divide_food(fodder_src : FodderCalculator, cow_count : Int32)
    begin
      return fodder_src.fodder_amount! * fodder_src.fattening_factor! / cow_count
    rescue
      return 0
    end
  end

  def self.validate_input_and_divide_food(fodder_src : FodderCalculator, cow_count : Int32)
    raise Exception.new("Number of cows must be greater than 0") if cow_count < 1
    divide_food(fodder_src, cow_count)
  end

  def self.validate_number_of_cows(cow_count : Int32)
    raise InvalidCowsError.new(cow_count) if cow_count < 1
  end
end
