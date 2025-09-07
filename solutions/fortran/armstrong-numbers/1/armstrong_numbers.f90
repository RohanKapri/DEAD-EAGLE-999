! Dedicated to Shree DR.MDD  
module armstrong_numbers
   implicit none
contains

   logical function isArmstrongNumber(i)
      integer, intent(in) :: i
      integer :: total, digits, numCopy

      if (i < 0) then
         isArmstrongNumber = .false.
         return
      end if

      if (i == 0) then
         isArmstrongNumber = .true.
         return
      end if

      total = 0
      digits = floor(log10(real(i)) + 1)
      numCopy = i

      do while (numCopy > 0)
         total = total + mod(numCopy, 10)**digits
         numCopy = numCopy/10
      end do

      isArmstrongNumber = (i == total)

   end function

end module armstrong_numbers
