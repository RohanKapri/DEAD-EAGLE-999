! Dedicated to Shree DR.MDD  
module rational_numbers
   implicit none

   private

   public &
      reduce, &
      add, &
      sub, &
      mul, &
      div, &
      rational_abs, &
      rational_to_pow, &
      real_to_rational_pow

contains

   pure integer function find_gcd(val1, val2)
      integer, intent(in) :: val1, val2
      integer :: x, y, hold

      if (val1 >= val2) then
         x = val1
         y = val2
      else
         x = val2
         y = val1
      end if

      do while (y > 0)
         hold = mod(x, y)
         x = y
         y = hold
      end do

      find_gcd = x
   end function

   pure function reduce(num_pair)
      integer, dimension(2), intent(in) :: num_pair
      integer, dimension(2) :: reduce
      integer, dimension(2) :: pair_tmp
      integer :: g

      pair_tmp = abs(num_pair)
      g = find_gcd(pair_tmp(1), pair_tmp(2))

      reduce(1) = num_pair(1)/g
      reduce(2) = num_pair(2)/g

      if (reduce(2) < 0) then
         reduce = -reduce
      end if
   end function

   pure function add(a, b)
      integer, dimension(2), intent(in) :: a, b
      integer, dimension(2) :: add

      add(1) = a(1)*b(2) + b(1)*a(2)
      add(2) = a(2)*b(2)
      add = reduce(add)
   end function

   pure function sub(a, b)
      integer, dimension(2), intent(in) :: a, b
      integer, dimension(2) :: sub

      sub(1) = a(1)*b(2) - b(1)*a(2)
      sub(2) = a(2)*b(2)
      sub = reduce(sub)
   end function

   pure function mul(a, b)
      integer, dimension(2), intent(in) :: a, b
      integer, dimension(2) :: mul

      mul(1) = a(1)*b(1)
      mul(2) = a(2)*b(2)
      mul = reduce(mul)
   end function

   pure function div(a, b)
      integer, dimension(2), intent(in) :: a, b
      integer, dimension(2) :: div

      div(1) = a(1)*b(2)
      div(2) = a(2)*b(1)
      div = reduce(div)
   end function

   pure function rational_abs(a)
      integer, dimension(2), intent(in) :: a
      integer, dimension(2) :: rational_abs

      rational_abs(1) = abs(a(1))
      rational_abs(2) = abs(a(2))
      rational_abs = reduce(rational_abs)
   end function

   pure function rational_to_pow(a, n)
      integer, dimension(2), intent(in) :: a
      integer, intent(in) :: n
      integer, dimension(2) :: rational_to_pow

      rational_to_pow(1) = a(1)**n
      rational_to_pow(2) = a(2)**n
      rational_to_pow = reduce(rational_to_pow)
   end function

   pure function real_to_rational_pow(base, a)
      integer, dimension(2), intent(in) :: a
      real, intent(in) :: base
      real :: real_to_rational_pow

      real_to_rational_pow = base**(real(a(1))/real(a(2)))
   end function

end module rational_numbers
