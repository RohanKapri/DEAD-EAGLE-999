module main

struct Pair {
    column int
    row    int
}

struct WordLocation {
    start Pair
    end   Pair
}

fn search(grid []string, words_to_search_for []string) map[string]?WordLocation {
    mut result := map[string]?WordLocation{}
    directions := [
        [1, 0],   // Right
        [-1, 0],  // Left
        [0, 1],   // Down
        [0, -1],  // Up
        [1, 1],   // Down-Right
        [-1, -1], // Up-Left
        [1, -1],  // Up-Right
        [-1, 1],  // Down-Left
    ]

    for word in words_to_search_for {
        word_len := word.len
        if word_len == 0 {
            result[word] = none
            continue
        }

        mut found := false
        for i in 0 .. grid.len {
            row := grid[i]
            for j in 0 .. row.len {
                for dir in directions {
                    dx, dy := dir[0], dir[1]
                    mut valid := true

                    for k in 0 .. word_len {
                        current_i := i + dy * k
                        current_j := j + dx * k

                        if current_i < 0 || current_i >= grid.len {
                            valid = false
                            break
                        }

                        current_row := grid[current_i]
                        if current_j < 0 || current_j >= current_row.len {
                            valid = false
                            break
                        }

                        if current_row[current_j] != word[k] {
                            valid = false
                            break
                        }
                    }

                    if valid {
                        start_col := j + 1
                        start_row := i + 1
                        end_col := j + dx * (word_len - 1) + 1
                        end_row := i + dy * (word_len - 1) + 1

                        result[word] = WordLocation{
                            start: Pair{start_col, start_row},
                            end: Pair{end_col, end_row},
                        }
                        found = true
                        break
                    }
                }
                if found {
                    break
                }
            }
            if found {
                break
            }
        }

        if !found {
            result[word] = none
        }
    }

    return result
}