//Fixed code for inv5
pred inv5_OK {
	all x, y : State | x->Event->y in trans implies 
		forall z : State | y->Event->z in trans implies x->Event->z in trans
}