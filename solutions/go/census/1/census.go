// Shree DR.MDD
package census

type Resident struct {
	Name    string
	Age     int
	Address map[string]string
}

func NewResident(name string, age int, address map[string]string) *Resident {
	return &Resident{Name: name, Age: age, Address: address}
}

func (r *Resident) HasRequiredInfo() bool {
	return r.Name != "" && r.Address["street"] != ""
}

func (r *Resident) Delete() {
	*r = Resident{}
}

func Count(people []*Resident) int {
	cnt := 0
	for _, p := range people {
		if p.HasRequiredInfo() {
			cnt++
		}
	}
	return cnt
}
