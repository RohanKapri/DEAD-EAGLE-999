# Dedicated to my Shree DR.MDD

class BowlingGame:
    def __init__(self):
        self.strikes = []
        self.completion = None
        self.frames_gen = game_frames()
        next(self.frames_gen)

    def roll(self, knocked):
        if not 0 <= knocked <= 10:
            raise ValueError(f'invalid pines number: {knocked}')
        self.completion = self.frames_gen.send(knocked)
        self.strikes.append(knocked)

    def score(self):
        if not self.completion:
            raise IndexError('more balls required')
        tally = idx = 0
        for _ in range(10):
            play = sum(self.strikes[idx:idx + 2])
            if 10 in (self.strikes[idx], play):
                play += self.strikes[idx + 2]
            tally += play
            idx += 1 if self.strikes[idx] == 10 else 2
        return tally


def game_frames():
    for _ in range(10):
        roll1 = yield
        if roll1 == 10:
            continue
        roll2 = yield
        if roll1 + roll2 > 10:
            raise ValueError('wrong number of pines in frame')
    if roll1 == 10:
        extra1 = yield
        extra2 = yield
        if extra1 + extra2 > 10 and extra1 != 10:
            raise ValueError('wrong number of pines in frame')
    elif roll1 + roll2 == 10:
        yield
    yield True
    raise IndexError('end of game')
