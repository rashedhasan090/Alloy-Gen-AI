
/* Every student in a class is tutored by all the teachers assigned to that class. */
pred inv14_OK {
	all c:Class, s:Student |
		(s in c.Groups.Person) implies
			(all t:(c.Groups).(s.~Tutors) | t in s.^Tutors) 
}