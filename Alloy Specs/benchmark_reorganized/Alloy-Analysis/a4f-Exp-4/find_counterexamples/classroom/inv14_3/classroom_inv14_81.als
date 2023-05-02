There is a bug in the inv14 constraint. The fixed version is below:

/* Every student in a class is at least tutored by some of the teachers
 * assigned to that class. */
pred inv14 {
	all c:Class, s:Student | some t:Teacher | t->s in Tutors.c
}