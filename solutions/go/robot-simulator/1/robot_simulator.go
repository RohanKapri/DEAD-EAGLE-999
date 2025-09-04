package robot

import "errors"

// See defs.go for other definitions

// Step 1
// Define N, E, S, W here.
const (
	N Dir = iota
	E
	S
	W
)

var (
	right   = map[Dir]Dir{N: E, E: S, S: W, W: N}
	left    = map[Dir]Dir{N: W, E: N, S: E, W: S}
	advance = map[Dir]Pos{N: {0, 1}, E: {1, 0}, S: {0, -1}, W: {-1, 0}}
	dir     = map[Dir]string{N: "North", E: "East", S: "South", W: "West"}
)

func Right() { Step1Robot.Dir = right[Step1Robot.Dir] }
func Left()  { Step1Robot.Dir = left[Step1Robot.Dir] }
func Advance() {
	Step1Robot.X += int(advance[Step1Robot.Dir].Easting)
	Step1Robot.Y += int(advance[Step1Robot.Dir].Northing)
}

func (d Dir) String() string { return dir[d] }

// Step 2
// Define Action type here.
type Action byte

func StartRobot(command chan Command, action chan Action) {
	for cmd := range command {
		action <- Action(cmd)
	}
	close(action)
}

func (s *Step2Robot) Right() { s.Dir = right[s.Dir] }
func (s *Step2Robot) Left()  { s.Dir = left[s.Dir] }
func (s *Step2Robot) Advance() Pos {
	return Pos{
		s.Easting + advance[s.Dir].Easting,
		s.Northing + advance[s.Dir].Northing,
	}
}
func (p *Pos) InRoom(ext Rect) bool {
	return p.Easting >= ext.Min.Easting &&
		p.Easting <= ext.Max.Easting &&
		p.Northing >= ext.Min.Northing &&
		p.Northing <= ext.Max.Northing
}

func Room(extent Rect, robot Step2Robot, action chan Action, report chan Step2Robot) {
	for command := range action {
		switch command {
		case 'L':
			robot.Left()
		case 'R':
			robot.Right()
		case 'A':
			if pos := robot.Advance(); pos.InRoom(extent) {
				robot.Pos = pos
			}
		}
	}
	report <- robot
	close(report)
}

// Step 3
// Define Action3 type here.
type Action3 struct {
	name   string
	action Action
	done   bool
}

func StartRobot3(name, script string, action chan Action3, log chan string) {
	for _, cmd := range script {
		action <- Action3{name, Action(cmd), false}
	}
	action <- Action3{name: name, action: 0, done: true}
}

func Room3(extent Rect, robots []Step3Robot, action chan Action3, rep chan []Step3Robot, log chan string) {
	defer func() { rep <- robots }()

	if err := room3validation(robots, extent); err != nil {
		log <- err.Error()
		return
	}
	room3sim(robots, action, log, extent)
}

func room3sim(robots []Step3Robot, action chan Action3, log chan string, extent Rect) {
	active := len(robots)
	for command := range action {
		r := getRobot(command.name, robots)
		switch {
		case r == nil:
			log <- "bad robot"
			return
		case command.done:
			active--
		case command.action == 'L':
			r.Left()
		case command.action == 'R':
			r.Right()
		case command.action == 'A':
			r.Advance3(extent, log, robots)
		default:
			log <- "Bad Command: " + string(command.action)
			return
		}
		if active == 0 {
			return
		}
	}
}

func (r *Step3Robot) Advance3(extent Rect, log chan string, robots []Step3Robot) {
	pos := r.Advance()
	switch {
	case !pos.InRoom(extent):
		log <- "outside of room"
	case collision(robots, pos, r.Name):
		log <- "collision"
	default:
		r.Pos = pos
	}
}

func getRobot(name string, robots []Step3Robot) *Step3Robot {
	for i := range robots {
		if robots[i].Name == name {
			return &robots[i]
		}
	}
	return nil
}

func room3validation(robots []Step3Robot, extent Rect) error {
	for i, robot1 := range robots {
		switch {
		case robot1.Name == "":
			return errors.New("no name")
		case !robot1.Step2Robot.Pos.InRoom(extent):
			return errors.New("outside of room")
		}
		for _, robot2 := range robots[i+1:] {
			switch {
			case equal(robot1.Pos, robot2.Pos):
				return errors.New("same location")
			case robot1.Name == robot2.Name:
				return errors.New("same name")
			}
		}
	}
	return nil
}

func collision(robots []Step3Robot, pos Pos, self string) bool {
	for _, robot := range robots {
		if robot.Name != self && equal(robot.Pos, pos) {
			return true
		}
	}
	return false
}

func equal(pos1, pos2 Pos) bool {
	return pos1.Easting == pos2.Easting && pos1.Northing == pos2.Northing
}