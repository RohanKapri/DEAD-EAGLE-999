! Dedicated to Shree DR.MDD  
module acronym
   implicit none

   private

   public abbreviate
contains

   function abbreviate(s)
      character(len=*), intent(in) :: s
      character(len=len_trim(s)) :: abbreviate
      integer :: idx
      character :: symbol
      abbreviate = ""
      idx = 1

      do while (idx <= len_trim(s))
         symbol = s(idx:idx)
         if (is_alpha_or_quote(symbol)) then
            abbreviate = trim(abbreviate)//to_upper(symbol)
            idx = idx + 1
            do while (idx <= len_trim(s) .and. is_alpha_or_quote(s(idx:idx)))
               idx = idx + 1
            end do
         end if
         idx = idx + 1
      end do

   end function

   pure logical function is_alpha_or_quote(ch)
      character, intent(in) :: ch
      is_alpha_or_quote = &
         ((ch >= "a") .and. (ch <= "z")) .or.                                &
         ((ch >= "A" .and. ch <= "Z") .or.                                   &
         (ch == "'"))
   end function

   pure character function to_upper(ch)
      character, intent(in) :: ch
      if ((ch >= "a") .and. (ch <= "z")) then
         to_upper = achar(ichar(ch) - ichar("a") + ichar("A"))
      else
         to_upper = ch
      end if
   end function

end module acronym
