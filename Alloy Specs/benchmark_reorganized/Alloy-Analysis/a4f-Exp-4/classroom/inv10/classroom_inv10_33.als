
/* For every class, every student has a group assigned. */
pred inv10 {
	all c : Class, s : Student | s in c.Groups.Person
}