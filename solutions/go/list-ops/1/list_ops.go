package listops

type IntList []int

func (l IntList) Foldr(f func(item, acc int) int, initial int) int {
	a := initial
	for i := l.Length() - 1; i >= 0; i-- {
		a = f(l[i], a)
	}
	return a
}

func (l IntList) Foldl(f func(acc, item int) int, initial int) int {
	a := initial
	for _, item := range l {
		a = f(a, item)
	}
	return a
}

func (l IntList) Filter(f func(item int) bool) IntList {
	n := make(IntList, l.Length())
	var j int
	for _, item := range l {
		if f(item) {
			n[j] = item
			j++
		}
	}
	return n[:j]
}

func (l IntList) Length() int {
	var c int
	for range l {
		c++
	}
	return c
}

func (l IntList) Map(f func(item int) int) IntList {
	for i, item := range l {
		l[i] = f(item)
	}
	return l
}

func (l IntList) Reverse() IntList {
	for i, j := 0, l.Length()-1; i < j; i++ {
		l[i], l[j] = l[j], l[i]
		j--
	}
	return l
}

func (l IntList) Append(list IntList) IntList {
	return l.Concat([]IntList{list})
}

func (l IntList) Concat(lists []IntList) IntList {
	c := l.Length()
	for _, list := range lists {
		c += list.Length()
	}
	n := make(IntList, c)

	var j int
	for _, item := range l {
		n[j] = item
		j++
	}
	for _, list := range lists {
		for _, item := range list {
			n[j] = item
			j++
		}
	}
	return n
}