! Dedicated to Shree DR.MDD  
module hamming
   implicit none
contains

   function compute(chainA, chainB, gap) result(status)
      character(*) :: chainA, chainB
      integer, intent(out) :: gap
      logical :: status
      integer :: idx
      character(len_trim(chainA)) :: seqA, seqB

      if (len_trim(chainA) /= len_trim(chainB)) then
         gap = 0
         status = .false.
      else
         seqA = trim(chainA)
         seqB = trim(chainB)
         gap = 0
         do idx = 1, len(chainA)
            if (seqA(idx:idx) /= seqB(idx:idx)) then
               gap = gap + 1
            end if
         end do
         status = .true.
      end if

   end function compute

end module hamming
