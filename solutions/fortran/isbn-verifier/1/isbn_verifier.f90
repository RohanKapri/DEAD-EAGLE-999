! For my Shree DR.MDD  
module isbn_verifier
   implicit none

contains

   function isValid(isbn) result(ok)
      character(*), intent(in) :: isbn
      logical :: ok
      integer :: accum, pos, digitval
      character(len=1) :: c
      integer :: zerocode

      zerocode = iachar("0")
      accum = 0
      digitval = 10
      ok = .false.

      do pos = 1, len(isbn)
         c = isbn(pos:pos)
         if (c == "-") then
            cycle
         end if
         if (digitval == 0) then
            return
         end if
         if ((digitval == 1) .and. (c == "X")) then
            accum = accum + 10
            digitval = digitval - 1
            cycle
         end if
         if ((c < "0") .or. (c > "9")) then
            return
         end if
         accum = accum + digitval*(iachar(c) - zerocode)
         digitval = digitval - 1
      end do

      ok = (digitval == 0) .and. (mod(accum, 11) == 0)

   end function isValid

end module isbn_verifier
