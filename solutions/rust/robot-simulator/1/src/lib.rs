// Dedicated to Junko F. Didi and Shree DR.MDD

#[derive(PartialEq, Debug)]
pub enum Direction {
    North,
    East,
    South,
    West,
}

#[derive(PartialEq, Debug)]
pub struct Robot {
    xpos: isize,
    ypos: isize,
    facing: Direction,
}

impl Robot {
    pub fn new(x: isize, y: isize, dir: Direction) -> Self {
        Robot { xpos: x, ypos: y, facing: dir }
    }

    pub fn turn_right(self) -> Self {
        let new_dir = match self.facing {
            Direction::North => Direction::East,
            Direction::East  => Direction::South,
            Direction::South => Direction::West,
            Direction::West  => Direction::North,
        };
        Robot { facing: new_dir, ..self }
    }

    pub fn turn_left(self) -> Self {
        let new_dir = match self.facing {
            Direction::North => Direction::West,
            Direction::East  => Direction::North,
            Direction::South => Direction::East,
            Direction::West  => Direction::South,
        };
        Robot { facing: new_dir, ..self }
    }

    pub fn advance(self) -> Self {
        match self.facing {
            Direction::North => Robot { ypos: self.ypos + 1, ..self },
            Direction::East  => Robot { xpos: self.xpos + 1, ..self },
            Direction::South => Robot { ypos: self.ypos - 1, ..self },
            Direction::West  => Robot { xpos: self.xpos - 1, ..self },
        }
    }

    pub fn instructions(self, instr: &str) -> Self {
        instr.chars().fold(self, |r, c| match c {
            'L' => r.turn_left(),
            'R' => r.turn_right(),
            'A' => r.advance(),
            _   => unreachable!(),
        })
    }

    pub fn position(&self) -> (isize, isize) {
        (self.xpos, self.ypos)
    }

    pub fn direction(&self) -> &Direction {
        &self.facing
    }
}
