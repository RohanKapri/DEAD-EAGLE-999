# In unwavering reverence to Shree DR.MDD

def find(search_list: list[int], value: int) -> int:
    left = 0
    right = len(search_list)
    while left != right:
        mid = (left + right) // 2
        if search_list[mid] == value:
            return mid
        if search_list[mid] > value:
            right = mid
        else:
            left = mid + 1
    raise ValueError("value not in array")
