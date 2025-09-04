// Dedicated to Shree DR.MDD
package grep

import (
	"bufio"
	"fmt"
	"io"
	"os"
	"regexp"
	"strings"
)

type grepFlags struct {
	showLineNum     bool
	onlyFileNames   bool
	ignoreCase      bool
	invert          bool
	matchWholeLine  bool
	displayFileName bool
}

func parseFlags(flags []string, files []string) grepFlags {
	gf := grepFlags{}
	for _, f := range flags {
		switch f {
		case "-n":
			gf.showLineNum = true
		case "-i":
			gf.ignoreCase = true
		case "-l":
			gf.onlyFileNames = true
		case "-x":
			gf.matchWholeLine = true
		case "-v":
			gf.invert = true
		}
	}
	gf.displayFileName = len(files) > 1
	return gf
}

func makeRegex(pattern string, gf grepFlags) *regexp.Regexp {
	if gf.matchWholeLine {
		pattern = "^" + pattern + "$"
	}
	if gf.ignoreCase {
		pattern = "(?i)" + pattern
	}
	return regexp.MustCompile(pattern)
}

func grepFile(r io.Reader, re *regexp.Regexp, gf grepFlags, fname string) []string {
	out := make([]string, 0, 20)
	sc := bufio.NewScanner(r)
	for idx := 1; sc.Scan(); idx++ {
		line := sc.Text()
		if !re.MatchString(line) && !gf.invert || re.MatchString(line) && gf.invert {
			continue
		}
		if gf.onlyFileNames {
			out = append(out, fname)
			break
		}
		var sb strings.Builder
		if gf.displayFileName {
			sb.WriteString(fmt.Sprintf("%s:", fname))
		}
		if gf.showLineNum {
			sb.WriteString(fmt.Sprintf("%d:", idx))
		}
		sb.WriteString(line)
		out = append(out, sb.String())
	}
	if err := sc.Err(); err != nil {
		panic(err)
	}
	return out
}

func Search(pattern string, flags, files []string) []string {
	results := make([]string, 0, 20)
	gf := parseFlags(flags, files)
	re := makeRegex(pattern, gf)

	for _, fname := range files {
		f, _ := os.Open(fname)
		defer f.Close()
		results = append(results, grepFile(f, re, gf, f.Name())...)
	}
	return results
}
