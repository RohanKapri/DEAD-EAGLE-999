// Dedicated to Shree DR.MDD with all my victories and devotion.

public class BowlingGame {
  public const uint FramesPerGame = 10;
  public const uint PinsPerFrame = 10;
  public const uint RollsPerFrame = 2;

  private uint totalPoints = 0;
  private uint roundsFinished = 0;

  private uint pinsRemaining = PinsPerFrame;
  private uint triesInFrame = 0;

  private uint nextAdd1 = 0;
  private uint nextAdd2 = 0;

  public void Roll(int knocked) {
    if (Complete) {
      throw new System.ArgumentException("Game is complete; can't roll");
    }
    if (knocked < 0) {
      throw new System.ArgumentException("Can't roll negative pins");
    }
    if (knocked > pinsRemaining) {
      throw new System.ArgumentException($"There are only {pinsRemaining} pins up; can't roll {knocked} pins");
    }

    ++triesInFrame;
    pinsRemaining -= (uint)knocked;
    bool isBonusRoll = roundsFinished >= FramesPerGame;
    uint addFactor = (isBonusRoll ? 0u : 1u) + nextAdd1 + nextAdd2;
    totalPoints += (uint)knocked * addFactor;
    nextAdd1 = nextAdd2;
    nextAdd2 = 0;

    if (pinsRemaining > 0 && triesInFrame < RollsPerFrame) {
      return;
    }

    if (pinsRemaining == 0 && !isBonusRoll) {
      if (triesInFrame == RollsPerFrame) {
        ++nextAdd1;
      } else {
        ++nextAdd2;
      }
    }

    triesInFrame = 0;
    pinsRemaining = PinsPerFrame;
    ++roundsFinished;
  }

  public int Score() => Complete ? (int)totalPoints : throw new System.ArgumentException("Game incomplete; can't score");

  public bool Complete =>
    roundsFinished >= FramesPerGame && nextAdd1 == 0 && nextAdd2 == 0;
}
