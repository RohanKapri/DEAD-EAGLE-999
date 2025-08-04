class Integer
  @@roman_nums = {
    'M'=>1000,
    'CM' => 900,
    'D'=>500,
    'CD' => 400,
    'C'=>100,
    'XC' => 90,
    'L'=>50,
    'XL' => 40,
    'X'=>10,
    'IX' => 9,
    'V'=>5,
    'IV' => 4,
    'I'=>1,
  }
  
  def desestruct(num)
    results = []
    num.to_s.reverse.split("").each_with_index do |digit, i|
      if digit != "0"
        results.push(digit.to_i * (10**i))
      end
    end
    results.reverse
  end

  def format_array(array)
    allow_numbers = @@roman_nums.values
    res = []
    index = 0
    while array.size > 0
        if allow_numbers[index] == array[0]
          res.push(array[0])
          array.shift          
        elsif array[0] > allow_numbers[index]
          res.push(allow_numbers[index])
          array.insert(1, array[0] - allow_numbers[index])
          array.shift
        else
          index += 1
        end
    end
    res
  end
  
  def to_roman
    array_factors = format_array(desestruct(self))
    res = ""
    array_factors.map do |num| 
      @@roman_nums.each { |key, value| if num == value then res += key; end}
    end
    res
  end
end  