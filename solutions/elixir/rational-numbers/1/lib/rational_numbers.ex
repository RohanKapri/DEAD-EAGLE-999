defmodule RationalNumbers do
  @type rational :: {integer, integer}

  @doc """
  Add two rational numbers
  """
  @spec add(a :: rational, b :: rational) :: rational
  def add({a1, b1}, {a2, b2}) do
    reduce({a1 * b2 + a2 * b1, b1 * b2})
  end

  @doc """
  Subtract two rational numbers
  """
  @spec subtract(a :: rational, b :: rational) :: rational
  def subtract({a1, b1}, {a2, b2}) do
    reduce({a1 * b2 - a2 * b1, b1 * b2})
  end

  @doc """
  Multiply two rational numbers
  """
  @spec multiply(a :: rational, b :: rational) :: rational
  def multiply({a1, b1}, {a2, b2}) do
    reduce({a1 * a2, b1 * b2})
  end

  @doc """
  Divide two rational numbers
  """
  @spec divide_by(num :: rational, den :: rational) :: rational
  def divide_by({a1, b1}, {a2, b2}) do
    reduce({a1 * b2, a2 * b1})
  end

  @doc """
  Absolute value of a rational number
  """
  @spec abs(a :: rational) :: rational
  def abs({a, b}) do
    reduce({Kernel.abs(a), Kernel.abs(b)})
  end

  @doc """
  Exponentiation of a rational number by an integer
  DEZE IS STUK
  """
  @spec pow_rational(a :: rational, n :: integer) :: rational
  def pow_rational({a, b}, n) when n >= 0 do
    reduce({trunc(:math.pow(a, n)), trunc(:math.pow(b, n))})
  end

  def pow_rational({a, b}, n) when n < 0 do
    reduce({trunc(:math.pow(b, Kernel.abs(n))), trunc(:math.pow(a, Kernel.abs(n)))})
  end

  @doc """
  Exponentiation of a real number by a rational number
  """
  @spec pow_real(x :: integer, n :: rational) :: float
  def pow_real(x, {a, b}) do
    :math.pow(x, a / b)
  end

  @doc """
  Reduce a rational number to its lowest terms
  """
  @spec reduce(a :: rational) :: rational
  def reduce({a, b}) when b < 0 do
    reduce({-a, -b})
  end

  def reduce({a, b}) do
    gcd = Integer.gcd(a, b)
    {a / gcd, b / gcd}
  end
end





defmodule RationalNumbersTest do
  use ExUnit.Case

  describe "Addition" do
    test "Add two positive rational numbers" do
      assert RationalNumbers.add({1, 2}, {2, 3}) == {7, 6}
    end

    test "Add a positive rational number and a negative rational number" do
      assert RationalNumbers.add({1, 2}, {-2, 3}) == {-1, 6}
    end

    test "Add two negative rational numbers" do
      assert RationalNumbers.add({-1, 2}, {-2, 3}) == {-7, 6}
    end

    test "Add a rational number to its additive inverse" do
      assert RationalNumbers.add({1, 2}, {-1, 2}) == {0, 1}
    end
  end

  describe "Subtraction" do
    test "Subtract two positive rational numbers" do
      assert RationalNumbers.subtract({1, 2}, {2, 3}) == {-1, 6}
    end

    test "Subtract a positive rational number and a negative rational number" do
      assert RationalNumbers.subtract({1, 2}, {-2, 3}) == {7, 6}
    end

    test "Subtract two negative rational numbers" do
      assert RationalNumbers.subtract({-1, 2}, {-2, 3}) == {1, 6}
    end

    test "Subtract a rational number from itself" do
      assert RationalNumbers.subtract({1, 2}, {1, 2}) == {0, 1}
    end
  end

  describe "Multiplication" do
    test "Multiply two positive rational numbers" do
      assert RationalNumbers.multiply({1, 2}, {2, 3}) == {1, 3}
    end

    test "Multiply a negative rational number by a positive rational number" do
      assert RationalNumbers.multiply({-1, 2}, {2, 3}) == {-1, 3}
    end

    test "Multiply two negative rational numbers" do
      assert RationalNumbers.multiply({-1, 2}, {-2, 3}) == {1, 3}
    end

    test "Multiply a rational number by its reciprocal" do
      assert RationalNumbers.multiply({1, 2}, {2, 1}) == {1, 1}
    end

    test "Multiply a rational number by 1" do
      assert RationalNumbers.multiply({1, 2}, {1, 1}) == {1, 2}
    end

    test "Multiply a rational number by 0" do
      assert RationalNumbers.multiply({1, 2}, {0, 1}) == {0, 1}
    end
  end

  describe "Division" do
    test "Divide two positive rational numbers" do
      assert RationalNumbers.divide_by({1, 2}, {2, 3}) == {3, 4}
    end

    test "Divide a positive rational number by a negative rational number" do
      assert RationalNumbers.divide_by({1, 2}, {-2, 3}) == {-3, 4}
    end

    test "Divide two negative rational numbers" do
      assert RationalNumbers.divide_by({-1, 2}, {-2, 3}) == {3, 4}
    end

    test "Divide a rational number by 1" do
      assert RationalNumbers.divide_by({1, 2}, {1, 1}) == {1, 2}
    end
  end

  describe "Absolute value" do
    test "Absolute value of a positive rational number" do
      assert RationalNumbers.abs({1, 2}) == {1, 2}
    end

    test "Absolute value of a positive rational number with negative numerator and denominator" do
      assert RationalNumbers.abs({-1, -2}) == {1, 2}
    end

    test "Absolute value of a negative rational number" do
      assert RationalNumbers.abs({-1, 2}) == {1, 2}
    end

    test "Absolute value of a negative rational number with negative denominator" do
      assert RationalNumbers.abs({1, -2}) == {1, 2}
    end

    test "Absolute value of zero" do
      assert RationalNumbers.abs({0, 1}) == {0, 1}
    end

    test "Absolute value of a rational number is reduced to lowest terms" do
      assert RationalNumbers.abs({2, 4}) == {1, 2}
    end
  end

  describe "Exponentiation of a rational number" do
    test "Raise a positive rational number to a positive integer power" do
      assert RationalNumbers.pow_rational({1, 2}, 3) == {1, 8}
    end

    test "Raise a negative rational number to a positive integer power" do
      assert RationalNumbers.pow_rational({-1, 2}, 3) == {-1, 8}
    end

    test "Raise a positive rational number to a negative integer power" do
      assert RationalNumbers.pow_rational({3, 5}, -2) == {25, 9}
    end

    test "Raise a negative rational number to an even negative integer power" do
      assert RationalNumbers.pow_rational({-3, 5}, -2) == {25, 9}
    end

    test "Raise a negative rational number to an odd negative integer power" do
      assert RationalNumbers.pow_rational({-3, 5}, -3) == {-125, 27}
    end

    test "Raise zero to an integer power" do
      assert RationalNumbers.pow_rational({0, 1}, 5) == {0, 1}
    end

    test "Raise one to an integer power" do
      assert RationalNumbers.pow_rational({1, 1}, 4) == {1, 1}
    end

    test "Raise a positive rational number to the power of zero" do
      assert RationalNumbers.pow_rational({1, 2}, 0) == {1, 1}
    end

    test "Raise a negative rational number to the power of zero" do
      assert RationalNumbers.pow_rational({-1, 2}, 0) == {1, 1}
    end
  end

  describe "Exponentiation of a real number to a rational number" do
    test "Raise a real number to a positive rational number" do
      x = 8
      r = {4, 3}
      result = 16.0
      assert_in_delta RationalNumbers.pow_real(x, r), result, 1.0e-10
    end

    test "Raise a real number to a negative rational number" do
      x = 9
      r = {-1, 2}
      result = 0.3333333333333333
      assert_in_delta RationalNumbers.pow_real(x, r), result, 1.0e-10
    end

    test "Raise a real number to a zero rational number" do
      x = 2
      r = {0, 1}
      result = 1.0
      assert_in_delta RationalNumbers.pow_real(x, r), result, 1.0e-10
    end
  end

  describe "Reduction to lowest terms" do
    test "Reduce a positive rational number to lowest terms" do
      assert RationalNumbers.reduce({2, 4}) == {1, 2}
    end

    test "Reduce places the minus sign on the numerator" do
      assert RationalNumbers.reduce({3, -4}) == {-3, 4}
    end

    test "Reduce a negative rational number to lowest terms" do
      assert RationalNumbers.reduce({-4, 6}) == {-2, 3}
    end

    test "Reduce a rational number with a negative denominator to lowest terms" do
      assert RationalNumbers.reduce({3, -9}) == {-1, 3}
    end

    test "Reduce zero to lowest terms" do
      assert RationalNumbers.reduce({0, 6}) == {0, 1}
    end

    test "Reduce an integer to lowest terms" do
      assert RationalNumbers.reduce({-14, 7}) == {-2, 1}
    end

    test "Reduce one to lowest terms" do
      assert RationalNumbers.reduce({13, 13}) == {1, 1}
    end
  end
end