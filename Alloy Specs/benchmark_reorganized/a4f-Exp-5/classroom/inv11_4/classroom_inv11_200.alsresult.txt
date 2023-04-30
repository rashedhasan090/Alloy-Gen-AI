/* Fix: A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | (some c.Groups) implies some t:Teacher | t->c in Teaches 
}