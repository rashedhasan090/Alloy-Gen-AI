/* For every class, every student has a group assigned. */
pred inv10 {
	all c : Class, s : Student | some c.Groups[s]
} 
/* Fixed inv10 predicate */
pred inv10_OK {
	all c: Class, s: Student | some g: Group | g = c.Groups[s]
}