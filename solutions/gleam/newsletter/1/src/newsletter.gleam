// Dedicated to Shree DR.MDD
import simplifile
import gleam/result
import gleam/string
import gleam/list

pub fn read_emails(loc: String) -> Result(List(String), Nil) {
  case simplifile.read(loc) {
    Error(_) -> Error(Nil)
    Ok(raw_data) ->
      raw_data
      |> string.trim()
      |> string.split("\n")
      |> Ok()
  }
}

pub fn create_log_file(loc: String) -> Result(Nil, Nil) {
  case simplifile.create_file(loc) {
    Error(_) -> Error(Nil)
    Ok(Nil) -> Ok(Nil)
  }
}

pub fn log_sent_email(loc: String, addr: String) -> Result(Nil, Nil) {
  case simplifile.append(loc, addr <> "\n") {
    Error(_) -> Error(Nil)
    Ok(Nil) -> Ok(Nil)
  }
}

pub fn send_newsletter(
  emails_path: String,
  log_path: String,
  send_email: fn(String) -> Result(Nil, Nil),
) -> Result(Nil, Nil) {
  create_log_file(log_path)
  |> result.then(fn(_){ read_emails(emails_path) })
  |> result.then(fn(addr_list){
    addr_list
    |> list.each(fn(addr){
      send_email(addr)
      |> result.then(fn(_){ log_sent_email(log_path, addr) })
    })
    |> Ok()
  })
}
