
/* A class only has groups if it has a teacher assigned. */
pred inv11 {
	all c : Class, t : Teacher | (t -> c in Teaches) implies not (some p : Person, g : Group | c -> p -> g in Groups) 
}