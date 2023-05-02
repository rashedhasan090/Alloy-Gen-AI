pred inv14_OK {
	all s : Person, c : Class | (c.Groups & s) -> c.Teaches.Present.Tutors.s
}