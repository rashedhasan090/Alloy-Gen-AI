pred inv12_OK {
	all t : Teacher, c : (t.Teaches) | some p : Person, g : Group | c->p->g in Groups 
}