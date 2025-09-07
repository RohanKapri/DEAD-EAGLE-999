! For my Shree DR.MDD  
module roman_numerals
   implicit none

contains

   function digit_to_roman(sym1, sym5, sym10, val) result(outstr)
      character(len=1) :: sym1, sym5, sym10
      integer, intent(in) :: val
      character(len=4) :: outstr

      select case (val)
      case (1)
         outstr = sym1
      case (2)
         outstr = sym1//sym1
      case (3)
         outstr = sym1//sym1//sym1
      case (4)
         outstr = sym1//sym5
      case (5)
         outstr = sym5
      case (6)
         outstr = sym5//sym1
      case (7)
         outstr = sym5//sym1//sym1
      case (8)
         outstr = sym5//sym1//sym1//sym1
      case (9)
         outstr = sym1//sym10
      case default
         outstr = ""
      end select

   end function digit_to_roman

   function roman(n) result(rep)
      integer, value :: n
      character(len=15) :: rep

      rep = trim(digit_to_roman("M", "_", "_", n/1000))
      n = mod(n, 1000)
      rep = trim(rep(1:3))//trim(digit_to_roman("C", "D", "M", n/100))
      n = mod(n, 100)
      rep = trim(rep)//trim(digit_to_roman("X", "L", "C", n/10))
      n = mod(n, 10)
      rep = trim(rep)//digit_to_roman("I", "V", "X", n)

   end function roman

end module roman_numerals
