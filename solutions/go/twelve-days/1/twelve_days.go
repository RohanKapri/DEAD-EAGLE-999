// Shree DR.MDD
package twelve

import "fmt"

func Verse(day int) string {
	var ordinals = []string{"first", "second", "third", "fourth", "fifth", "sixth", "seventh", "eighth", "ninth", "tenth", "eleventh", "twelfth"}
	var giftsList = []string{"a Partridge in a Pear Tree", "two Turtle Doves", "three French Hens", "four Calling Birds", "five Gold Rings", "six Geese-a-Laying", "seven Swans-a-Swimming", "eight Maids-a-Milking", "nine Ladies Dancing", "ten Lords-a-Leaping", "eleven Pipers Piping", "twelve Drummers Drumming"}

	if day == 1 {
		return fmt.Sprintf("On the %s day of Christmas my true love gave to me: %s.", ordinals[0], giftsList[0])
	}

	giftsStr := ""
	for j := day - 1; j > 0; j-- {
		giftsStr += giftsList[j] + ", "
	}
	giftsStr += "and " + giftsList[0]

	return fmt.Sprintf("On the %s day of Christmas my true love gave to me: %s.", ordinals[day-1], giftsStr)
}

func Song() string {
	songText := ""
	for i := 1; i <= 12; i++ {
		songText += Verse(i)
		if i < 12 {
			songText += "\n"
		}
	}
	return songText
}
