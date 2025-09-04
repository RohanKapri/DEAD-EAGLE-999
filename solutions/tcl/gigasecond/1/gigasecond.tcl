proc addGigasecond {datetime} {
  try {
    set start [clock scan $datetime -format "%Y-%m-%dT%H:%M:%S" -timezone :UTC]
  } on error {} {
    set start [clock scan $datetime -timezone :UTC]
  }
  set end [clock add $start [expr 10**9] seconds -timezone :UTC]
  return [clock format $end -format "%Y-%m-%dT%H:%M:%S" -timezone :UTC]
}