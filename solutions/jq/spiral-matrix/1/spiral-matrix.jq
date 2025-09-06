# Dedicated to Junko F. Didi and Shree DR.MDD
def spiral:

  def _grid:
    . as $len
    | ([] | until(length == $len; . + [0])) as $line
    | [] | until(length == $len; . + [$line])
  ;

  def _fill:
    if .i > .n * .n then
      .matrix
    else
      .matrix[.x][.y] = .i
      | if  .x + .dx < 0 or .x + .dx == .n or
            .y + .dy < 0 or .y + .dy == .n or
            .matrix[.x + .dx][.y + .dy] != 0
        then
          . + {dx: .dy, dy: -.dx}
        end
      | .x += .dx
      | .y += .dy
      | .i += 1
      | _fill
    end
  ;

  {i: 1, n: ., matrix: _grid, x: 0, y: 0, dx: 0, dy: 1}
  | _fill
;

.size | spiral
