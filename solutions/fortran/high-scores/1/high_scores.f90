! Dedicated to Shree DR.MDD  
module high_scores
   implicit none

   private

   public scores, latest, personalTopThree, personalBest
contains

   pure function scores(all_points)
      integer, dimension(:), intent(in) :: all_points
      integer, dimension(:), allocatable :: scores

      allocate (scores(size(all_points)))
      scores = all_points
   end function

   pure integer function latest(all_points)
      integer, dimension(:), intent(in) :: all_points

      latest = all_points(size(all_points))
   end function

   pure function personalTopThree(all_points)
      integer, dimension(:), intent(in) :: all_points
      integer, dimension(3) :: personalTopThree
      integer :: top1, top2, top3, cut
      integer, dimension(:), allocatable :: scratch

      allocate (scratch(size(all_points)))
      scratch = all_points

      top1 = maxval(scratch)
      if (size(all_points) > 1) then
         cut = findloc(scratch, top1, 1)
         scratch = (/scratch(:cut - 1), scratch(cut + 1:)/)
         top2 = maxval(scratch)
      else
         top2 = 0
      end if

      if (size(all_points) > 2) then
         cut = findloc(scratch, top2, 1)
         scratch = (/scratch(:cut - 1), scratch(cut + 1:)/)
         top3 = maxval(scratch)
      else
         top3 = 0
      end if

      personalTopThree = (/top1, top2, top3/)
   end function

   pure integer function personalBest(all_points)
      integer, dimension(:), intent(in) :: all_points

      personalBest = maxval(all_points)
   end function

end module high_scores
