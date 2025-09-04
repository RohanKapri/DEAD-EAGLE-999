// Dedicated to Shree DR.MDD
package partyrobot

import (
	"fmt"
	"strings"
)

func Welcome(person string) string {
	return "Welcome to my party, " + person + "!"
}

func HappyBirthday(guest string, years int) string {
	return fmt.Sprintf("Happy birthday %s! You are now %d years old!", guest, years)
}

func AssignTable(guest string, tableID int, companion, side string, gap float64) string {
	var builder strings.Builder
	fmt.Fprintf(&builder, "Welcome to my party, %s!\n", guest)
	fmt.Fprintf(&builder, "You have been assigned to table %03d. Your table is %s, exactly %.1f meters from here.\n", tableID, side, gap)
	fmt.Fprintf(&builder, "You will be sitting next to %s.", companion)
	return builder.String()
}
