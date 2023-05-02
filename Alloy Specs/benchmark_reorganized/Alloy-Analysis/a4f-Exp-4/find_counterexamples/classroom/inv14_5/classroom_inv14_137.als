
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14_OK {
	all c : Class, s : Student, t : Teacher | c.Groups[s] = g and t in Teaches[c] implies s in t.Tutors[g]
}

The key change is to use c.Groups[s] to get the group g that the student s is assigned to in class c, and then to use t.Tutors[g] to check that teacher t is at least tutoring student s in group g.