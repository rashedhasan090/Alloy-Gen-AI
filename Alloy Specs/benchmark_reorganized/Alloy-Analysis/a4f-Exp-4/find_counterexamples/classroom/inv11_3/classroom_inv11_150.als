
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class,g:Group | g in Class.Teaches.(c -> Groups)
}