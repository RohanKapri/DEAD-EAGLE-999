module main

// Given a moment, determine the moment that would be after a gigasecond has passed.

import time

fn add_gigasecond(t time.Time) time.Time {
  gigasecond := time.Duration(1_000_000_000 * time.second)
  return t.add(gigasecond)
}