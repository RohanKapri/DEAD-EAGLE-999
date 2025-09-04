package strain

type Collection interface {
	int | string | []int
}

func Keep[T Collection](collection []T, filter func(T) bool) []T {
	res := make([]T, 0, len(collection))
	for _, element := range collection {
		if filter(element) {
			res = append(res, element)
		}
	}
	return res
}

func Discard[T Collection](collection []T, filter func(T) bool) []T {
	return Keep(collection, func(t T) bool { return !filter(t) })
}