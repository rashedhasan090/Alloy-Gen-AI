// Bug: The predicate inv14 is incorrectly written. The implication direction needs to be reversed. It should be "s in Tutors implies some t : Teacher | t -> s in Tutors". 
// Fixed code:
/* Every student in a class is at least tutored by all the teachers
 * assigned to that class. */
pred inv14 {
	all s : Person, c : Class, t : Person, g : Group | (c -> s -> g in Groups) and t -> c in Teaches implies s in Tutors implies some t. t -> s in Tutors
}