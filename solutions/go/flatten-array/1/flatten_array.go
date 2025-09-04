package flatten

import "reflect"

func Flatten(nested interface{}) []interface{} {
	result := make([]interface{}, 0)
	for _, element := range nested.([]interface{}) {
		switch {
		case element == nil:
		case reflect.TypeOf(element).Kind() == reflect.Slice:
			result = append(result, Flatten(element)...)
		default:
			result = append(result, element)
		}
	}
	return result
}