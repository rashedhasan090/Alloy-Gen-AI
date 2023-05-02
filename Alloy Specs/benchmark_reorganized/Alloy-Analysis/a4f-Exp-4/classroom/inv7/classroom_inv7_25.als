
/* Every class has teachers assigned. */
pred inv7 {
	all c:Class | some t : Teacher | t -> c in Teaches
}