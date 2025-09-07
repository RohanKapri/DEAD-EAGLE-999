! Dedicated to Shree DR.MDD  
module matrix
   implicit none

contains

   function row(m, m_dim, i) result(r)
      character(len=*), dimension(*) :: m
      integer, intent(in) :: m_dim(2)
      integer, intent(in) :: i
      integer, dimension(m_dim(2)) :: r
      integer :: grid(m_dim(1), m_dim(2))
      integer :: idx

      do idx = 1, m_dim(1)
         read(m(idx), *) grid(idx, :)
      end do

      r(:) = grid(i, :)
   end function

   function column(m, m_dim, j) result(c)
      character(len=*), dimension(*) :: m
      integer, intent(in) :: m_dim(2)
      integer, intent(in) :: j
      integer, dimension(m_dim(1)) :: c
      integer :: grid(m_dim(1), m_dim(2))
      integer :: idx

      do idx = 1, m_dim(1)
         read(m(idx), *) grid(idx, :)
      end do

      c(:) = grid(:, j)
   end function

end module matrix
