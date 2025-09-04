# Change any of the following NamedTuple values to true to 
# enable testing different bonus tasks
tested_bonus_tasks = (rev = false, by = false, lt = false, multiple_matches = false)

function binarysearch(search_list, value)
    len = length(search_list)
    first = 1
    last = len
    while first <= last
        mid = ÷((first + last), 2)
        if search_list[mid] == value
            return mid:mid
        end
        if search_list[mid] < value
            first = mid + 1
        else
            last = mid - 1
        end
    end
    first < len && search_list[first] == value ? (first:first) : first:(first - 1)
end