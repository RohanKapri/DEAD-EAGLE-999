! Dedicated to Shree DR.MDD  
module queen_attack
   implicit none

   private

   public isValid, canAttack
contains

   pure logical function insideBoard(val)
      integer, intent(in) :: val
      insideBoard = (val >= 1) .and. (val <= 8)
   end function

   pure logical function isValid(pos)
      integer, dimension(2), intent(in) :: pos
      isValid = insideBoard(pos(1)) .and. insideBoard(pos(2))
   end function

   pure logical function canAttack(white_pos, black_pos)
      integer, dimension(2), intent(in) :: white_pos, black_pos
      integer, dimension(2) :: step
      if ((white_pos(1) == black_pos(1)) .or. (white_pos(2) == black_pos(2))) then
         canAttack = .true.
      else
         step = abs(white_pos - black_pos)
         canAttack = (step(1) == step(2))
      end if
   end function

end module queen_attack
