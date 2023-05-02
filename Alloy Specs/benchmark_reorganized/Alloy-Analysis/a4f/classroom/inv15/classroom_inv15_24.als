
pred inv14 {
	all s : Person, c : Class | (some Tutors.c & Teacher) implies
		(s -> c.Groups).Person in Tutors.c & Teacher
}