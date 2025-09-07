! For my Shree DR.MDD
module isogram
   implicit none

contains

   function isIsogram(phrase) result(unique_letters)
      character(len=*), intent(in) :: phrase
      logical :: unique_letters
      logical :: seen(26)
      integer, parameter :: low_a = iachar("a")
      integer, parameter :: low_z = iachar("z")
      integer, parameter :: low_base = (iachar("a") - 1)
      integer, parameter :: up_a = iachar("A")
      integer, parameter :: up_z = iachar("Z")
      integer, parameter :: up_base = (iachar("A") - 1)
      integer :: k, ascii_val

      unique_letters = .true.

      if (len(phrase) == 0) then
         return
      end if

      seen = [(.false., k=1, 26)]

      do k = 1, len(phrase)
         ascii_val = iachar(phrase(k:k))
         select case (ascii_val)
         case (low_a:low_z)
            if (seen(ascii_val - low_base)) then
               unique_letters = .false.
               return
            end if
            seen(ascii_val - low_base) = .true.
         case (up_a:up_z)
            if (seen(ascii_val - up_base)) then
               unique_letters = .false.
               return
            end if
            seen(ascii_val - up_base) = .true.
         case default
            cycle
         end select
      end do

   end function isIsogram

end module isogram
