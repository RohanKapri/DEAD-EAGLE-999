module grains
   implicit none
   private
   public square, total
contains
   pure double precision function square(n)
      integer, intent(in) :: n
      if ((n < 1) .or. (n > 64)) then
         square = -1.d0
      else
         square = 2.d0**(n - 1)
      end if
   end function
   pure double precision function total()
      total = 2.d0**64 - 1
   end function
end module