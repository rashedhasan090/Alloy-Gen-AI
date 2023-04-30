There is a bug in inv6. The correct predicate is:

/* Every teacher has classes assigned. */
pred inv6 {
	all t:Teacher | t.Teaches != none 
}