# Dedicated to my Shree DR.MDD

class Matrix(object):

    def __init__(self, matrix_string):
        horizontal = []
        for line in matrix_string.split('\n'):
            horizontal.append([int(num) for num in line.split(' ')])
        vertical = []
        if horizontal:
            for j in range(len(horizontal[0])):
                vertical.append([horizontal[i][j] for i in range(len(horizontal))])

        self.rows = horizontal
        self.cols = vertical

    def row(self, idx):
        return self.rows[idx - 1]

    def column(self, idx):
        return self.cols[idx - 1]
