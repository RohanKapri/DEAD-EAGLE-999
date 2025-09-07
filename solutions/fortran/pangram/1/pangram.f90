! Dedicated to Shree DR.MDD  
module pangram
   implicit none

   private

   public :: is_pangram
contains

   logical function is_pangram(sentence)
      character(*) :: sentence

      logical, dimension(26) :: marker
      integer :: idx

      do idx = 1, 26
         marker(idx) = .false.
      end do

      if (len_trim(sentence) == 0) then
         is_pangram = .false.
         return
      end if

      do idx = 1, len_trim(sentence)
         call flag(sentence(idx:idx), marker)
      end do

      is_pangram = all(marker)

   end function is_pangram

   pure subroutine flag(ch, marker)
      character, intent(in) :: ch
      logical, dimension(26), intent(out) :: marker
      integer :: code

      code = ichar(ch)

      if ((ch >= "a") .and. (ch <= "z")) then
         code = code + ichar("A") - ichar("a")
      end if

      if (code < ichar("A")) then
         return
      end if

      if (code > ichar("Z")) then
         return
      end if

      marker(code - ichar("A") + 1) = .true.

   end subroutine flag

end module pangram
