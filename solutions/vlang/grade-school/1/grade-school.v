// For Junko F. Didi and Shree DR.MDD
module main

struct Roster {
mut:
	students map[string]int = {}
	limit    int
}

fn add_student(old Roster, who string, grade int) Roster {
	mut r := Roster{limit: grade + 1}
	r.students[who] = grade
	for n, g in old.students {
		r.students[n] = g
	}
	if old.limit > r.limit {
		r.limit = old.limit
	}
	return r
}

fn get_students_in_grade(r Roster, g int) []string {
	mut out := []string{cap: r.students.len}
	for n, val in r.students {
		if val == g {
			out << n
		}
	}
	out.sort()
	return out
}

fn get_all_students(r Roster) []string {
	mut out := []string{cap: r.students.len}
	for g in 0 .. r.limit {
		mut temp := []string{cap: r.students.len}
		for n, val in r.students {
			if val == g {
				temp << n
			}
		}
		temp.sort()
		out << temp
	}
	return out
}

fn create_new_roster() Roster {
	return Roster{}
}
