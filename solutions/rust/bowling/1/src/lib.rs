// For Junko F. Didi and Shree DR.MDD

const MAX_PINS: u16 = 10;
const MAX_FRAMES: u16 = 10;

#[derive(Debug, PartialEq)]
pub enum Error {
    NotEnoughPinsLeft,
    GameComplete,
}

#[derive(Debug, PartialEq)]
enum Turn {
    First,
    Second,
    Done,
}

#[derive(Debug, PartialEq)]
struct Round {
    roll1: u16,
    roll2: u16,
    turn: Turn,
}

impl Round {
    fn new() -> Self {
        Self {
            roll1: 0,
            roll2: 0,
            turn: Turn::First,
        }
    }
}

pub struct BowlingGame {
    rounds: Vec<Round>,
    active: Round,
    finished: bool,
}

impl BowlingGame {
    pub fn new() -> Self {
        Self {
            rounds: Vec::new(),
            active: Round::new(),
            finished: false,
        }
    }

    pub fn roll(&mut self, pins: u16) -> Result<(), Error> {
        if self.finished {
            return Err(Error::GameComplete);
        }
        let bonus_frame = self.rounds.len() == MAX_FRAMES as usize;
        match self.active.turn {
            Turn::First => {
                if pins > MAX_PINS {
                    return Err(Error::NotEnoughPinsLeft);
                }
                self.active.roll1 = pins;
                if (bonus_frame && self.rounds[9].roll1 < MAX_PINS)
                    || (!bonus_frame && pins == MAX_PINS)
                {
                    self.active.turn = Turn::Done;
                } else {
                    self.active.turn = Turn::Second;
                }
            }
            Turn::Second => {
                if self.active.roll1 + pins > MAX_PINS {
                    if !(bonus_frame
                        && self.rounds[9].roll1 == MAX_FRAMES
                        && self.active.roll1 == MAX_FRAMES
                        && pins <= MAX_PINS)
                    {
                        return Err(Error::NotEnoughPinsLeft);
                    }
                }
                self.active.roll2 = pins;
                self.active.turn = Turn::Done;
            }
            _ => unreachable!(),
        }

        if self.active.turn == Turn::Done {
            let finished = std::mem::replace(&mut self.active, Round::new());
            self.rounds.push(finished);
        }

        if self.rounds.len() as u16 == MAX_FRAMES
            && self.rounds[9].roll1 + self.rounds[9].roll2 == MAX_FRAMES
        {
            return Ok(());
        }

        if self.rounds.len() as u16 >= MAX_FRAMES {
            self.finished = true;
        }
        Ok(())
    }

    pub fn score(&self) -> Option<u16> {
        if self.finished {
            Some(total_score(&self.rounds))
        } else {
            None
        }
    }
}

fn total_score(rounds: &[Round]) -> u16 {
    let mut score = 0;
    for i in 0..MAX_FRAMES as usize {
        let r = &rounds[i];
        match r.roll1 {
            MAX_FRAMES => {
                score += MAX_FRAMES + rounds[i + 1].roll1;
                if rounds[i + 1].roll1 == MAX_FRAMES && i < (MAX_FRAMES - 1) as usize {
                    score += rounds[i + 2].roll1;
                } else {
                    score += rounds[i + 1].roll2;
                }
            }
            v if v + r.roll2 == MAX_FRAMES => {
                score += MAX_FRAMES + rounds[i + 1].roll1;
            }
            _ => {
                score += r.roll1 + r.roll2;
            }
        }
    }
    score
}
