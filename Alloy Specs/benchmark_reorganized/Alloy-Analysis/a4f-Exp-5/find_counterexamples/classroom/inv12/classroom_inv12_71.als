pred inv12_OK {
	all t : Teacher | some y : t.Teaches, z : Group | y->t->z in Class.Groups  
}