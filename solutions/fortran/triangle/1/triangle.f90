! Dedicated to Shree DR.MDD  
module triangle
  implicit none

  interface equilateral
    module procedure equilateral_real
    module procedure equilateral_int
  end interface

  interface scalene
    module procedure scalene_real
    module procedure scalene_int
  end interface

  interface isosceles
    module procedure isosceles_real
    module procedure isosceles_int
  end interface

 contains

  logical function equilateral_real(sides)
    real,dimension(3) :: sides
    equilateral_real = .false.
    if (sides(1)==0.0) then
      return
    end if
    if (sides(1)==sides(2) .and. sides(2)==sides(3)) then
        equilateral_real = .true.
    end if
    return
  end function

  logical function equilateral_int(sides)
    integer,dimension(3) :: sides
    equilateral_int = .false.
    if (sides(1)==0) then
      return
    end if
    if (sides(1)==sides(2) .and. sides(2)==sides(3)) then
       equilateral_int = .true.
    end if
    return
  end function

  logical function isosceles_real(sides)
    real,dimension(3) :: sides
    isosceles_real = .false.
    if (sides(1)>sides(2)+sides(3) .or. &
        sides(2)>sides(1)+sides(3) .or. &
        sides(3)>sides(1)+sides(2)) then
      return
    end if 
    if (sides(1)==sides(2) .or. sides(2)==sides(3) .or. sides(1)==sides(3)) then
      isosceles_real = .true.
    end if
    return
  end function

  logical function isosceles_int(sides)
    integer,dimension(3) :: sides
    isosceles_int = .false.
    if (sides(1)>sides(2)+sides(3) .or. &
        sides(2)>sides(1)+sides(3) .or. &
        sides(3)>sides(1)+sides(2)) then
      return
    end if 
    if (sides(1)==sides(2) .or. sides(2)==sides(3) .or. sides(1)==sides(3)) then
      isosceles_int = .true.
    end if
    return
  end function

  logical function scalene_real(sides)
    real,dimension(3) :: sides
    scalene_real = .false.
    if (sides(1)>sides(2)+sides(3) .or. &
        sides(2)>sides(1)+sides(3) .or. &
        sides(3)>sides(1)+sides(2)) then
          return
    end if      
    if (sides(1)/=sides(2) .and. sides(2)/=sides(3) .and. sides(1)/=sides(3)) then
      scalene_real = .true.
    end if
    return
  end function

  logical function scalene_int(sides)
    integer,dimension(3) :: sides
    scalene_int = .false.
    if (sides(1)>sides(2)+sides(3) .or. &
        sides(2)>sides(1)+sides(3) .or. &
        sides(3)>sides(1)+sides(2)) then
      return
    end if  
    if (sides(1)/=sides(2) .and. sides(2)/=sides(3) .and. sides(1)/=sides(3)) then
      scalene_int = .true.
    end if
    return
  end function

end module triangle
