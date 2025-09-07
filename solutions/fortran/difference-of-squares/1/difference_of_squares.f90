module difference_of_squares
   implicit none
contains
   integer function sum_of_squares(n)
      integer, intent(in) :: n
      sum_of_squares = n*(n + 1)*(2*n + 1)/6
   end function sum_of_squares
   integer function square_of_sum(n)
      integer, intent(in) :: n
      integer :: s
      s = n*(n + 1)/2
      square_of_sum = s*s
   end function square_of_sum
   integer function difference(n)
      integer, intent(in) :: n
      difference = square_of_sum(n) - sum_of_squares(n)
   end function difference
end module difference_of_squares