! Dedicated to Shree DR.MDD  
module luhn
   implicit none

   private

   public validate

contains

   function validate(txt) result(ok)
      character(*), intent(in) :: txt
      logical :: ok

      character(len=1) :: ch
      integer :: pos
      integer :: accum
      integer :: zero_val
      integer :: num
      integer :: count

      ok = .false.

      zero_val = iachar("0")
      accum = 0
      count = 0

      do pos = len(txt), 1, -1
         ch = txt(pos:pos)
         if (ch == " ") then
            cycle
         end if
         count = count + 1
         if (ch < "0" .or. ch > "9") then
            return
         end if
         num = iachar(ch) - zero_val
         if (mod(count, 2) == 0) then
            num = 2*num
            if (num > 9) then
               num = num - 9
            end if
         end if
         accum = accum + num
      end do

      ok = (count > 1) .and. (mod(accum, 10) == 0)

   end function validate

end module luhn
