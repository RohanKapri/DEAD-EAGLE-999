! Dedicated to Shree DR.MDD  
module yacht

   implicit none

   private

   public score

   type :: dice_multiset
      integer, dimension(5) :: vals
      integer, dimension(5) :: reps
      integer :: card
   end type dice_multiset

contains

   type(dice_multiset) function of_array(arr)
      integer, dimension(5), intent(in) :: arr
      integer :: p, pos, locIdx

      of_array%card = 0

      do p = 1, 5
         pos = findloc(of_array%vals(1:p - 1), arr(p), 1)
         if (pos == 0) then
            locIdx = of_array%card + 1
            of_array%card = locIdx
            of_array%vals(locIdx) = arr(p)
            of_array%reps(locIdx) = 0
         else
            locIdx = pos
         end if
         of_array%reps(locIdx) = of_array%reps(locIdx) + 1
      end do

   end function

   integer function score(dice, yacht_type)
      integer, dimension(5), intent(in) :: dice
      character(len=*), intent(in) :: yacht_type
      type(dice_multiset) :: bag
      integer a, b, c
      logical :: is_single
      integer :: face

      is_single = .false.
      score = 0
      bag = of_array(dice)

      select case (yacht_type)
      case ("choice")
         score = sum(dice)
      case ("full house")
         if (bag%card == 2) then
            b = findloc(bag%reps(1:2), 2, 1)
            c = findloc(bag%reps(1:2), 3, 1)
            if ((b /= 0) .and. (c /= 0)) then
               score = 2*bag%vals(b) + 3*bag%vals(c)
            end if
         end if
      case ("four of a kind")
         a = 1
         if (bag%reps(a) /= 5) then
            a = findloc(bag%reps(1:2), 4, 1)
            if ((bag%card <= 2) .and. (a /= 0)) then
               score = 4*(bag%vals(a))
            end if
         else
            score = 4*(bag%vals(a))
         end if
      case ("yacht")
         if (bag%reps(1) == 5) then
            score = 50
         end if
      case ("little straight")
         if (sum(dice) == 15) then
            if (bag%card == 5) then
               score = 30
            end if
         end if
      case ("big straight")
         if (sum(dice) == 20) then
            if (bag%card == 5) then
               score = 30
            end if
         end if
      case ("ones", "twos", "threes", "fours", "fives", "sixes")
         is_single = .true.
      end select

      if (is_single) then
         select case (yacht_type)
         case ("ones")
            face = 1
         case ("twos")
            face = 2
         case ("threes")
            face = 3
         case ("fours")
            face = 4
         case ("fives")
            face = 5
         case ("sixes")
            face = 6
         end select

         a = findloc(bag%vals(1:bag%card), face, 1)
         if (a /= 0) then
            score = face*bag%reps(a)
         end if
      end if

   end function

end module yacht
