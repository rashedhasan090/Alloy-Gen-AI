
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c:Class | some t:Teacher | some g:Group | g in c.Groups.t
}