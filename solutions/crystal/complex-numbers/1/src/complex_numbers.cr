class Complex
  getter real, imaginary
  EPSILON = 1e-9

  def initialize(@real : Float64, @imaginary : Float64)
  end

  def +(other : Complex) : Complex
    Complex.new(real + other.real, imaginary + other.imaginary)
  end

  def -(other : Complex) : Complex
    Complex.new(real - other.real, imaginary - other.imaginary)
  end

  def *(other : Complex) : Complex
    Complex.new(real * other.real - imaginary * other.imaginary, real * other.imaginary + imaginary * other.real)
  end

  def /(other : Complex) : Complex
    denominator = other.real**2 + other.imaginary**2
    Complex.new((real * other.real + imaginary * other.imaginary) / denominator, (imaginary * other.real - real * other.imaginary) / denominator)
  end

  def +(other : Number) : Complex
    Complex.new(real + other.to_f64, imaginary)
  end

  def -(other : Number) : Complex
    Complex.new(real - other.to_f64, imaginary)
  end

  def *(other : Number) : Complex
    Complex.new(real * other.to_f64, imaginary * other.to_f64)
  end

  def /(other : Number) : Complex
    raise ArgumentError.new("Division by zero") if other.to_f64 == 0
    Complex.new(real / other.to_f64, imaginary / other.to_f64)
  end

  def self.from_number(number : Number) : Complex
    Complex.new(number.to_f64, 0)
  end

  def abs : Float64
    Math.sqrt(real**2 + imaginary**2)
  end

  def conjugate : Complex
    Complex.new(real, -imaginary)
  end

  def exp : Complex
    Complex.new(Math.exp(real), 0) * Complex.new(Math.cos(imaginary), Math.sin(imaginary))
  end

  def ==(other : Complex) : Bool
    (real - other.real).abs < EPSILON && (imaginary - other.imaginary).abs < EPSILON
  end

  def to_s : String
    "#{real} + #{imaginary}i"
  end
end

struct Number
  def +(complex : Complex)
    Complex.new(self, 0) + complex
  end

  def -(complex : Complex)
    Complex.new(self, 0) - complex
  end

  def *(complex : Complex)
    Complex.new(self, 0) * complex
  end

  def /(complex : Complex)
    Complex.new(self, 0) / complex
  end
end