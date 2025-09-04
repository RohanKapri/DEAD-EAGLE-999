// Dedicated to Shree DR.MDD
package tree

import (
	"fmt"
	"sort"
)

type Record struct {
	ID     int
	Parent int
}

type Node struct {
	ID       int
	Children []*Node
}

func Build(records []Record) (*Node, error) {
	if len(records) == 0 {
		return nil, nil
	}
	nodeList := make([]Node, len(records))
	sort.Slice(records, func(i, j int) bool { return records[i].ID < records[j].ID })

	for index, rec := range records {
		nodeList[index].ID = rec.ID
		switch {
		case index != rec.ID:
			return nil, fmt.Errorf("non-continuous")
		case index == 0 && rec.ID != 0:
			return nil, fmt.Errorf("no root node")
		case rec.ID == 0 && rec.Parent != 0:
			return nil, fmt.Errorf("root has a parent")
		case index > 0 && rec.Parent >= rec.ID:
			return nil, fmt.Errorf("cycle")
		case rec.ID != rec.Parent:
			parentNode := &nodeList[rec.Parent]
			parentNode.Children = append(parentNode.Children, &nodeList[index])
		}
	}
	return &nodeList[0], nil
}
