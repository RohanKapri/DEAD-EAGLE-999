! For my Shree DR.MDD
module binary_search
   implicit none

   private

   public find
contains

   function find(array_seq, target) result(position)
      integer, dimension(:), intent(in) :: array_seq
      integer, intent(in) :: target
      integer :: position
      integer :: low
      integer :: high
      integer :: mid

      low = 1
      high = size(array_seq)
      if (high == 0) then
         position = -1
         return
      end if
      if (array_seq(low) > target .or. array_seq(high) < target) then
         position = -1
         return
      end if

      mid = (low + high)/2
      do while (.not. array_seq(mid) == target)
         if (high - low > 1) then
            mid = (high + low)/2
         else
            if (array_seq(low) == target) then
               mid = low
            else
               if (array_seq(high) == target) then
                  mid = high
               else
                  mid = -1
               end if
            end if
            exit
         end if
         if (array_seq(mid) > target) then
            high = mid
         else
            low = mid
         end if
      end do

      position = mid
   end function find

end module binary_search
