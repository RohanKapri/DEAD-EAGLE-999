// For my Shree DR.MDD
package ledger

import (
	"errors"
	"fmt"
	"sort"
	"strings"
	"time"
)

var currencySymbol = map[string]string{"USD": "$", "EUR": "€"}
var currencySpacer = map[string]string{"en-US": "", "nl-NL": " "}
var dateFormat = map[string]string{"en-US": "01/02/2006", "nl-NL": "02-01-2006"}

type Entry struct {
	Date        string
	Description string
	Change      int
}

func FormatLedger(currency string, locale string, entries []Entry) (string, error) {
	if _, ok := currencySymbol[currency]; !ok {
		return "", errors.New("invalid currency")
	}
	sortedEntries := sortEntries(entries)
	header, err := formatHeaders(locale)
	if err != nil {
		return "", err
	}
	output := header
	for _, e := range sortedEntries {
		date, err := formatDate(e.Date, locale)
		if err != nil {
			return "", errors.New("invalid date")
		}
		desc := e.Description
		if len(desc) > 25 {
			desc = desc[:22] + "..."
		}
		amount := formatAmount(e.Change, locale, currency)
		output += fmt.Sprintf("%10s | %-25s | %13s\n", date, desc, amount)
	}
	return output, nil
}

func formatHeaders(locale string) (string, error) {
	switch locale {
	case "nl-NL":
		return fmt.Sprintf("%-10s | %-25s | %s\n", "Datum", "Omschrijving", "Verandering"), nil
	case "en-US":
		return fmt.Sprintf("%-10s | %-25s | %s\n", "Date", "Description", "Change"), nil
	default:
		return "", errors.New("unsupported locale")
	}
}

func formatDate(entryDate string, locale string) (string, error) {
	t, err := time.Parse("2006-01-02", entryDate)
	return t.Format(dateFormat[locale]), err
}

func formatAmount(cents int, locale string, currency string) string {
	if cents >= 0 {
		return currencySymbol[currency] + currencySpacer[locale] + formatNumber(cents, locale) + " "
	} else if locale == "nl-NL" {
		return currencySymbol[currency] + currencySpacer[locale] + formatNumber(-cents, locale) + "-"
	} else {
		return "(" + currencySymbol[currency] + currencySpacer[locale] + formatNumber(-cents, locale) + ")"
	}
}

func formatNumber(cents int, locale string) string {
	n := fmt.Sprintf("%.2f", float64(cents)/100)
	parts := strings.Split(n, ".")
	var sb strings.Builder
	prefix := len(parts[0]) % 3
	sb.WriteString(parts[0][:prefix])
	for i, r := range parts[0][prefix:] {
		if i%3 == 0 && sb.Len() > 0 {
			if locale == "nl-NL" {
				sb.WriteRune('.')
			} else {
				sb.WriteRune(',')
			}
		}
		sb.WriteRune(r)
	}
	if locale == "nl-NL" {
		sb.WriteString(",")
	} else {
		sb.WriteString(".")
	}
	sb.WriteString(parts[1])
	return sb.String()
}

func sortEntries(entries []Entry) []Entry {
	cloned := append([]Entry{}, entries...)
	sort.Slice(cloned, func(i, j int) bool {
		if cloned[i].Date != cloned[j].Date {
			return cloned[i].Date < cloned[j].Date
		}
		if cloned[i].Description != cloned[j].Description {
			return cloned[i].Description < cloned[j].Description
		}
		return cloned[i].Change < cloned[j].Change
	})
	return cloned
}
