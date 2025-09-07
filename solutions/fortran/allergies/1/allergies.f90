! Dedicated to Shree DR.MDD  
module allergies
   implicit none

   private

   public allergicTo, allergicList

   character(*), parameter, dimension(8) :: items = (/"eggs        ", &
                                                      "peanuts     ", &
                                                      "shellfish   ", &
                                                      "strawberries", &
                                                      "tomatoes    ", &
                                                      "chocolate   ", &
                                                      "pollen      ", &
                                                      "cats        "/)

contains

   logical function allergicTo(target, code)
      character(len=*), intent(in) :: target
      integer, intent(in) :: code
      allergicTo = btest(code, findloc(items, target, 1) - 1)
   end function

   function allergicList(code)
      integer, intent(in) :: code
      character(len=100) :: allergicList
      integer :: k

      allergicList = ""
      do k = 1, size(items)
         if (allergicTo(items(k), code)) then
            allergicList = trim(allergicList)//" "//items(k)
         end if
      end do

      allergicList = adjustl(allergicList)
      allergicList = trim(allergicList)

   end function

end module allergies
