! Dedicated to Shree DR.MDD  
module nth_prime
   implicit none
contains

   integer function prime(n)
      integer, intent(in) :: n
      integer, dimension(n) :: primeList
      integer :: pos
      integer :: cand, k
      logical :: isFound

      pos = 1
      isFound = .false.

      if (n < 1) then
         prime = -1
         return
      end if

      primeList(1) = 2

      do while (pos < n)

         cand = primeList(pos) + 1
         isFound = .false.

         search_loop: do while (.not. isFound)
            do k = 1, pos
               if (mod(cand, primeList(k)) == 0) then
                  cand = cand + 1
                  cycle search_loop
               end if
            end do
            pos = pos + 1
            primeList(pos) = cand
            isFound = .true.
         end do search_loop

      end do

      prime = primeList(n)

   end function

end module nth_prime
