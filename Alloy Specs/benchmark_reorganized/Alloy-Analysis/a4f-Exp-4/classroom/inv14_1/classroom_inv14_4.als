
/* Every student in a class is at least tutored by all the teachers assigned to that class. */
pred inv14 {
	all c : Class, s : Student |
		s in c.Groups.Group.Tutors.Teacher and
		Teaches.c.Teacher in s.Tutors
}