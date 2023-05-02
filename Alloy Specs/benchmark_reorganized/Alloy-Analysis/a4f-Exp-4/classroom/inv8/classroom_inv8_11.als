
/* Teachers are assigned at most one class. */
pred inv8 {
	all t : Teacher | lone c : Class | t -> c in Teaches
}