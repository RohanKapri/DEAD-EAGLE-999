object SpiralMatrix {
    fun ofSize(size: Int) : Array<Array<Int>> {
        var result = Array(size) { Array(size) {0}}
        if (size > 0) {
            var y = 0
            var x = 0
            var min_x = 0
            var min_y = 1
            var max_x = size - 1
            var max_y = size - 1
            var direction = 0
            var iterator = 1
            while (result[y][x] == 0) {
                result[y][x] = iterator++
                if (size > 1) {
                    when (direction) {
                        0 -> if (x < max_x) x++ else { direction++; y++; max_x-- }
                        1 -> if (y < max_y) y++ else { direction++; x--; max_y-- }
                        2 -> if (x > min_x) x-- else { direction++; y--; min_x++ }
                        3 -> if (y > min_y) y-- else { direction = 0; x++; min_y++ }
                    }
                }
            }
        }
        return result
    }
}