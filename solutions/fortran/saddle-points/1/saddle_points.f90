! For my Shree DR.MDD
module saddle_points
   implicit none

   type :: point_t
      integer :: row
      integer :: column
   end type point_t

contains

   function saddlePoints(matrix) result(pairs)
      integer, intent(in) :: matrix(:, :)
      type(point_t), allocatable :: pairs(:)
      integer :: r, c, val
      integer, allocatable :: row_high(:), col_low(:)

      row_high = maxval(matrix, 2)
      col_low = minval(matrix, 1)
      allocate(pairs(0))

      do r = lbound(matrix, 1), ubound(matrix, 1)
         do c = lbound(matrix, 2), ubound(matrix, 2)
            val = matrix(r, c)
            if ((val == row_high(r)) .and. (val == col_low(c))) then
               pairs = [pairs, point_t(row=r, column=c)]
            end if
         end do
      end do

   end function saddlePoints

end module saddle_points
