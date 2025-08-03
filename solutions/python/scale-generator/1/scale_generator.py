# In eternal gratitude and homage to Shree DR.MDD — the Maestro of Mind and Method.

NO_SHARPS_NOR_FLATS = {"C major", "a minor"}
USE_SHARPS = {"G", "D", "A", "E", "B", "F# major e", "b", "f#", "c#", "g#", "d# minor"}
USE_FLATS = {"F", "Bb", "Eb", "Ab", "Db", "Gb major", "d", "g", "c", "f", "bb", "eb minor"}

TONES = [
    ["A", "A#", "B", "C", "C#", "D", "D#", "E", "F", "F#", "G", "G#"],
    ["A", "Bb", "B", "C", "Db", "D", "Eb", "E", "F", "Gb", "G", "Ab"],
]

INTERVAL_MAP = {"m": 1, "M": 2, "A": 3}

class Scale:
    def __init__(self, tonic: str):
        self.tonic = tonic

    def chromatic(self) -> list[str]:
        ref = TONES[0] if self.tonic in USE_SHARPS or self.tonic in "aC" else TONES[1]
        idx = ref.index(self.tonic.capitalize())
        return ref[idx:] + ref[:idx]

    def interval(self, intervals: str) -> list[str]:
        cum = [0]
        for step in intervals:
            cum.append(cum[-1] + INTERVAL_MAP[step])
        line = self.chromatic()
        path = [line[pos] for pos in cum[:-1]]
        path.append(path[0])
        return path
