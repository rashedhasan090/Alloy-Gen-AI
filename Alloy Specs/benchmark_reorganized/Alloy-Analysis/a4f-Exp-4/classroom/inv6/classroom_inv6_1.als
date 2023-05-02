The bug was found in the inv6 predicate, where the equation had an incorrect relation between Teacher and Teaches.Class. The fixed code for inv6 is:

/* Every teacher has classes assigned. */
pred inv6 {
	all t:Teacher | t.Teaches != none
}