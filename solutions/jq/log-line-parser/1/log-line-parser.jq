def trim: sub("^\\s+"; "") | sub("\\s+$"; "");
def message:
  trim
  | sub("^\\[[[:upper:]]+\\]:\\s*"; "")
;
def log_level:
  trim
  | match("^\\[([[:upper:]]+)\\]:")
  | .captures[0].string
  | ascii_downcase
;
def reformat:
  "\(message) (\(log_level))"
;