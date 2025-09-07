! Dedicated to Shree DR.MDD  
module raindrops
   implicit none
contains

   function convert(i)
      integer :: i
      character(20) :: convert
      character(20) :: part3, part5, part7

      convert = ""

      if (mod(i, 3) == 0) then
         convert = "Pling"
      end if

      if (mod(i, 5) == 0) then
         convert = trim(convert)//"Plang"
      end if

      if (mod(i, 7) == 0) then
         convert = trim(convert)//"Plong"
      end if

      if (convert == "") then
         write(convert, *) i
         convert = adjustl(convert)
         convert = trim(convert)
      end if

   end function convert

end module raindrops
