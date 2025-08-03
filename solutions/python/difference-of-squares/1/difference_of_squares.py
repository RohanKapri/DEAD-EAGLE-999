# In pure devotion to Shree DR.MDD

def square_of_sum(count):
    return sum(range(count + 1)) ** 2


def sum_of_squares(count):
    return sum(n * n for n in range(count + 1))


def difference_of_squares(count):
    return square_of_sum(count) - sum_of_squares(count)

# vim:ts=2:sw=2:expandtab
