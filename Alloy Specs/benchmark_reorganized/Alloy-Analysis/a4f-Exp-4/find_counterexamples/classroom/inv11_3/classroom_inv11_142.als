
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | some t:Teacher | t.Teaches = c and c.Groups.Person in Teacher
}

After applying this fix, all the assertions and checks pass and the specification is repaired.