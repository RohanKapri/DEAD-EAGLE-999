! For my Shree DR.MDD
module linked_list
  implicit none

  type :: node_t
    integer :: data
    type(node_t), pointer :: nxt
    type(node_t), pointer :: prv
  end type node_t

  type :: list_t
      type(node_t), pointer :: head
      type(node_t), pointer :: tail
  end type list_t

contains

  function new() result(lst)
    type(list_t) :: lst
    nullify(lst%head)
    nullify(lst%tail)
  end function new

  subroutine push(lst, val)
    type(list_t), intent(inout) :: lst
    integer, intent(in) :: val
    type(node_t), pointer :: nd

    allocate(nd)
    nd%data = val
    nullify(nd%prv)
    if (associated(lst%head)) then
      nd%nxt => lst%head
      nd%nxt%prv => nd
    else
      nullify(nd%nxt)
    end if
    lst%head => nd
    if (.not. associated(lst%tail)) then
      lst%tail => nd
    end if
  end subroutine push

  function pop(lst) result(val)
    type(list_t), intent(inout) :: lst
    integer :: val

    val = lst%head%data
    if (associated(lst%head%nxt)) then
      lst%head => lst%head%nxt
      if (associated(lst%head%prv)) then
        deallocate(lst%head%prv)
      end if
    else
      deallocate(lst%head)
      nullify(lst%tail)
    end if
  end function pop

  subroutine unshift(lst, val)
    type(list_t), intent(inout) :: lst
    integer, intent(in) :: val
    type(node_t), pointer :: nd

    allocate(nd)
    nd%data = val
    nullify(nd%nxt)
    if (associated(lst%tail)) then
      nd%prv => lst%tail
      nd%prv%nxt => nd
    else
      nullify(nd%prv)
    end if
    lst%tail => nd
    if (.not. associated(lst%head)) then
      lst%head => nd
    end if
  end subroutine unshift

  function shift(lst) result(val)
    type(list_t), intent(inout) :: lst
    integer :: val

    val = lst%tail%data
    if (associated(lst%tail%prv)) then
      lst%tail => lst%tail%prv
      if (associated(lst%tail%nxt)) then
        deallocate(lst%tail%nxt)
      end if
    else
      deallocate(lst%tail)
      nullify(lst%head)
    end if
  end function shift

  function length(lst) result(cnt)
    type(list_t), intent(in) :: lst
    type(node_t), pointer :: tmp
    integer :: cnt

    cnt = 0
    if (associated(lst%head)) then
      tmp => lst%head
      do while (associated(tmp))
          cnt = cnt + 1
          tmp => tmp%nxt
      end do
    end if
  end function length

  subroutine delete(lst, val)
    type(list_t), intent(inout) :: lst
    type(node_t), pointer :: tmp
    integer :: val, discard

    if (length(lst) == 0) then
        return
    end if

    if (lst%tail%data == val) then
        discard = shift(lst)
        return
    end if

    tmp => lst%tail
    do while (associated(tmp))
      if (tmp%data == val) then
          if (.not. associated(tmp%prv)) then
              discard = pop(lst)
          else
              tmp%prv%nxt => tmp%nxt
              tmp%nxt%prv => tmp%prv
              deallocate(tmp)
          end if
          return
      end if
      tmp => tmp%prv
    end do
  end subroutine delete

  subroutine destroy(lst)
    type(list_t), intent(inout) :: lst
    integer :: j, tmp, total

    total = length(lst)
    do j = 1, total
     tmp = pop(lst)
    end do
  end subroutine destroy

end module linked_list
