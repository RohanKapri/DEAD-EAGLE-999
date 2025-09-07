! For my Shree DR.MDD  
module sieve
   implicit none

   private

   public primes

contains

   function primes(limit) result(nums)
      integer, intent(in) :: limit
      integer, allocatable :: nums(:)
      integer :: idx, k, pick

      if (limit < 2) then
         allocate(nums(0))
         return
      end if

      nums = [(idx, idx=2, limit)]

      idx = 1
      do while (idx <= size(nums))
         pick = nums(idx)
         nums = pack(nums, [(.true., k=1, idx), mod(nums((idx+1):), pick) /= 0])
         idx = idx + 1
      end do

   end function primes

end module sieve
