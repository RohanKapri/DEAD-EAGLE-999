package secret
func Handshake(code uint) []string {
	s := []string{}
	if code&uint(1) > 0 {
		s = append(s, "wink")
	}
	if code&uint(2) > 0 {
		s = append(s, "double blink")
	}
	if code&uint(4) > 0 {
		s = append(s, "close your eyes")
	}
	if code&uint(8) > 0 {
		s = append(s, "jump")
	}
	if code&uint(16) > 0 {
		for i, j := 0, len(s)-1; i < j; i, j = i+1, j-1 {
			s[i], s[j] = s[j], s[i]
		}
	}
	return s
}