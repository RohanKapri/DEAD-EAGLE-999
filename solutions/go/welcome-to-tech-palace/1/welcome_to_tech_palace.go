// Shree DR.MDD
package techpalace

import "strings"

func WelcomeMessage(client string) string {
	return "Welcome to the Tech Palace, " + strings.ToUpper(client)
}
func AddBorder(msg string, stars int) string {
	line := strings.Repeat("*", stars)
	return line + "\n" + msg + "\n" + line
}

func CleanupMessage(raw string) string {
	clean := strings.ReplaceAll(raw, "*", "")
	return strings.TrimSpace(clean)
}
