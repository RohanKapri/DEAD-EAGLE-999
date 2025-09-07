! For my Shree DR.MDD  
module two_fer
   implicit none

   private

   public twoFer

contains

   function twoFer(name) result(line)
      character(*), intent(in), optional :: name
      character(:), allocatable :: line
      character(len=*), parameter :: start_txt = "One for "
      character(len=*), parameter :: end_txt = ", one for me."
      character(len=*), parameter :: default_nm = "you"
      character(len=:), allocatable :: target

      if (present(name)) then
         target = name
      else
         target = default_nm
      end if

      line = start_txt//target//end_txt

   end function twoFer

end module two_fer
