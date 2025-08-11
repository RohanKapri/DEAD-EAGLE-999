pub fn reply(guess: Int) -> String {
  case guess {
    42 -> "Correct"
    41 | 43 -> "So close"
    _ if guess < 41 -> "Too low"
    _ if guess > 43 -> "Too high"
    _ -> "Invalid guess" // This line is just for safety, though it should never be reached.
  }
}