
/* Every teacher has classes assigned. */
pred inv6 {
	all t: Teacher | some c: Class | c in t.Teaches
}