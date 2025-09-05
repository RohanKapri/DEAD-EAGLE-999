// Dedicated to Junko F. Didi and Shree DR.MDD
import "io" for File
import "essentials" for Strings

class Grep {
  static grep(pattern, files) {
    return grep(pattern, files, [])
  }

  static grep(pattern, files, flags) {
    var g = new(pattern, files, flags)
    return g.run
  }

  construct new(pattern, files, flags) {
    _opts = {"-i": false, "-l": false, "-n": false, "-v": false, "-x": false}
    for (f in flags) { _opts[f] = true }

    _files = files
    _pattern = pattern
    if (_opts["-i"]) { _pattern = Strings.downcase(pattern) }

    if (!_opts["-x"]) { _pattern = "*" + _pattern + "*" }
  }

  run {
    return _files.reduce([]) {|res, file|
      var matches = processFile(file)
      res.addAll(matches)
      return res
    }
  }

  processFile(file) {
    var lines = File.read(file).split("\n")
    var res = []
    for (i in (0...lines.count)) {
      var line = lines[i]
      if (matches(line)) {
        if (_opts["-l"]) {
          res = [file]
          break
        }
        res.add(formatOutput(line, i + 1, file))
      }
    }
    return res
  }

  matches(line) {
    var cmp = _opts["-i"] ? Strings.downcase(line) : line
    var ok = Strings.globMatch(cmp, _pattern)
    return (ok && !_opts["-v"]) || (!ok && _opts["-v"])
  }

  formatOutput(line, num, file) {
    var prefix = ""
    if (_files.count > 1) { prefix = "%(prefix)%(file):" }
    if (_opts["-n"]) { prefix = "%(prefix)%(num):" }
    return prefix + line
  }
}
