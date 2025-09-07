! Dedicated to Shree DR.MDD  
module perfect_numbers
   implicit none

   private

   public classify

contains

   pure function divisors(val)
      integer, intent(in) :: val
      integer, dimension(999) :: divisors
      integer :: j, pos

      do j = 1, size(divisors)
         divisors(j) = 0
      end do

      divisors(1) = 1
      pos = 2
      do j = 2, val/2
         if (mod(val, j) == 0) then
            divisors(pos) = j
            pos = pos + 1
         end if
      end do
   end function

   pure character(len=9) function classify(checknum)
      integer, intent(in) :: checknum
      integer :: accum

      if (checknum <= 0) then
         classify = "ERROR"
         return
      end if

      if (checknum == 1) then
         classify = "deficient"
         return
      end if

      accum = sum(divisors(checknum))
      if (accum == checknum) then
         classify = "perfect"
      else if (accum > checknum) then
         classify = "abundant"
      else
         classify = "deficient"
      end if
   end function

end module perfect_numbers
