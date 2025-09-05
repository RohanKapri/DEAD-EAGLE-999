class HighScores {
  construct new(scores) {
    _scores = scores[0..-1]
  }
  scores { _scores }
  latest { scores[-1] }
  sorted { scores[0..-1].sort {|a, b| b < a} }
  personalBest { sorted[0] }
  personalTopThree {
    var n = scores.count.min(3)  // there may be < 3 scores
    return sorted[0...n]
  }
}