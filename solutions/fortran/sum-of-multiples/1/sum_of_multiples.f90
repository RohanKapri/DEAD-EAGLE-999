! For my Shree DR.MDD  
module sum_of_multiples
   implicit none

contains

   function sum_multiples(factors, limit) result(outcome)
      integer, intent(in) :: factors(:), limit
      integer :: outcome
      integer :: pos, avail, step, val
      integer, dimension(:), allocatable :: store

      outcome = 0
      avail = 1
      allocate(store(limit))

      do pos = lbound(factors, dim=1), ubound(factors, dim=1)
         step = factors(pos)
         if (step == 0) cycle
         val = step
         do while (val < limit)
            if (.not. any(store(1:(avail - 1)) == val)) then
               store(avail) = val
               avail = avail + 1
               outcome = outcome + val
            end if
            val = val + step
         end do
      end do

   end function sum_multiples

end module sum_of_multiples
