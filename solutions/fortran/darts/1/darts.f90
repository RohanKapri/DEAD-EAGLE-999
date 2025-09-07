module darts
   implicit none
contains
   function score(x, y) result(points)
      real, intent(in):: x, y
      integer :: points
      real :: sd
      sd = x*x + y*y
      if (sd <= 1.0) then
         points = 10
      else if (sd <= 25.0) then
         points = 5
      else if (sd <= 100.0) then
         points = 1
      else
         points = 0
      end if
   end function score
end module darts