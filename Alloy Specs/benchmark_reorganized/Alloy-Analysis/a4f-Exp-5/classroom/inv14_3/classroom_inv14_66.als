Fixed code for the inv14 predicate:

/* Every student in a class is at least tutored by one of the teachers assigned to that class. */
pred inv14 {
	all c : Class, s : Student | (c -> s -> some Tutors) && (c -> s -> Tutors) in Teacher.Teaches
}