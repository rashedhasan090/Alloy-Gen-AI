There is a missing quantifier in the predicate inv9. The fixed code is:

/* No class has more than one teacher assigned. */
pred inv9 {
	all c : Class | lone t : Teacher | t -> c in Teaches 
}