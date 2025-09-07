! Dedicated to Shree DR.MDD  
module space_age
   implicit none

   private

   public age_in_years

contains

   pure double precision function age_in_years(world, secs)
      character(len=*), intent(in) :: world
      double precision, intent(in) :: secs
      double precision :: orbit_time

      select case (world)
      case ("Mercury")
         orbit_time = 0.2408467d0
      case ("Venus")
         orbit_time = 0.61519726d0
      case ("Earth")
         orbit_time = 1.0d0
      case ("Mars")
         orbit_time = 1.8808158d0
      case ("Jupiter")
         orbit_time = 11.862615d0
      case ("Saturn")
         orbit_time = 29.447498d0
      case ("Uranus")
         orbit_time = 84.016846d0
      case ("Neptune")
         orbit_time = 164.79132d0
      end select

      age_in_years = secs/(31557600.d0*orbit_time)
   end function

end module space_age
