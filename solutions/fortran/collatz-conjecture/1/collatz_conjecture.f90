module collatz_conjecture
   implicit none
contains
   integer function steps(i)
      integer :: i
      integer :: current
      if (i <= 0) then
         steps = -1
         return
      end if
      current = i
      steps = 0
      do while (current /= 1)
         steps = steps + 1
         if (mod(current, 2) == 0) then
            current = current/2
         else
            current = 3*current + 1
         end if
      end do
   end function
end module