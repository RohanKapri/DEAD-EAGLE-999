proc custom_error_message {message} {
  return -code error $message
}
proc handle_error {script} {
  try {
    uplevel 1 $script
    return "success"
  } on error { result options } {
    switch -glob $result {
      "divide by zero"        { return "division by zero" }
      "couldn't open*"        { return "file does not exist" }
      "invalid command name*" { return "proc does not exist" }
      default                 { return "Unrecognized error: $result" }
    }
  }
}