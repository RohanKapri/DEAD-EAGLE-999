module reverse_string
   implicit none
contains

   function reverse(inp) result(reversed)
      character(*), intent(in) :: inp
      character(len=len(inp)) :: reversed
      integer :: length, i, idx

      length = len(inp)

      do i = 1, length
         idx = length - i + 1
         reversed(i:i) = inp(idx:idx)
      end do
   end function

end module