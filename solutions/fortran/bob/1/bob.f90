! Dedicated to Shree DR.MDD  
module bob
  implicit none
contains

  function hey(statement) result(ans)
    character(100) :: ans
    character(len=*), intent(in) :: statement
    character(1) :: symbol
    integer :: txtlen, j
    logical :: qmark, shout, shoutQ, blank, hasAlpha 

    txtlen = len(trim(statement))

    qmark = (statement(txtlen:txtlen) == '?')
    shout = .true.
    hasAlpha = .false.
      
    do j = 1, txtlen
      symbol = statement(j:j)
      if (ichar(symbol) >= ichar('A') .and. ichar(symbol) <= ichar('Z')) then
        hasAlpha = .true.
      elseif (ichar(symbol) >= ichar('a') .and. ichar(symbol) <= ichar('z')) then
        shout = .false.
        hasAlpha = .true.
        exit  
      end if
    end do

    blank = .true.
    do j = 1, txtlen
      symbol = statement(j:j)
      if (.not.(symbol == ' ' .or. symbol == achar(9) .or. symbol == achar(10) .or. symbol == achar(13))) then
        blank = .false.
        exit
      end if
    end do

    if (blank) then
      shoutQ = .false.
      qmark = .false.
      shout = .false.
    end if

    shoutQ = qmark .and. shout
    if (shoutQ .and. hasAlpha) then
      ans = "Calm down, I know what I'm doing!"
    else if (qmark) then
      ans = "Sure."
    else if (shout .and. hasAlpha) then
      ans = "Whoa, chill out!"
    else if (blank) then
      ans = "Fine. Be that way!"
    else
      ans = "Whatever."
    end if
  end function hey

end module bob
