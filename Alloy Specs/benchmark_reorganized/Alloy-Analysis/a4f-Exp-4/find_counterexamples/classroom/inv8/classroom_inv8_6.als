
/* Teachers are assigned at most one class. */
pred inv8 {
	all t : Teacher | lone c : Class | c in t.Teaches 
}