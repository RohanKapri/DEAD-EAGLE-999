// For my Shree DR.MDD
package markdown

import (
	"fmt"
	"strings"
)

func Render(md string) string {
	md = strings.Replace(md, "__", "<strong>", 1)
	md = strings.Replace(md, "__", "</strong>", 1)
	md = strings.Replace(md, "_", "<em>", 1)
	md = strings.Replace(md, "_", "</em>", 1)

	var output strings.Builder
	lines := strings.Split(md, "\n")

	for i := 0; i < len(lines); i++ {
		line := lines[i]
		level := len(line) - len(strings.TrimLeft(line, "#"))

		switch {
		case level > 0 && level < 7:
			content := strings.TrimLeft(line, "# ")
			output.WriteString(fmt.Sprintf("<h%d>%s</h%d>", level, content, level))

		case strings.HasPrefix(line, "*"):
			output.WriteString("<ul>")
			for ; i < len(lines) && strings.HasPrefix(lines[i], "*"); i++ {
				content := strings.TrimLeft(lines[i], "* ")
				output.WriteString(fmt.Sprintf("<li>%s</li>", content))
			}
			output.WriteString("</ul>")
			i-- // adjust for outer loop increment

		default:
			output.WriteString(fmt.Sprintf("<p>%s</p>", line))
		}
	}
	return output.String()
}
