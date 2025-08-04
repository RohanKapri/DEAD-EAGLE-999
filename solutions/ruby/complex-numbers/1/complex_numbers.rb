class ComplexNumber
  attr_reader :real, :imag

  def initialize(r, i = 0)
    @real, @imag = r.to_f, i.to_f
  end

  def imaginary
    imag
  end

  def ==(other)
    (real - other.real).abs < 0.000001 &&
    (imag - other.imag).abs < 0.000001
  end

  def +(other)
    self.class.new(real + other.real, imag + other.imag)
  end

  def -(other)
    self.class.new(real - other.real, imag - other.imag)
  end

  def *(other)
    self.class.new(real * other.real - imag * other.imag,
                   real * other.imag + imag * other.real)
  end

  def /(other)
    d = other.real**2 + other.imag**2
    self.class.new((real * other.real + imag * other.imag) / d,
                   (imag * other.real - real * other.imag) / d)
  end

  def abs
    (real ** 2 + imag ** 2) ** 0.5
  end

  def conjugate
    self.class.new(real, -imag)
  end

  def exp
    re = Math.exp(real)
    self.class.new(re * Math.cos(imag), re * Math.sin(imag))
  end
end

module BookKeeping VERSION = 1 end