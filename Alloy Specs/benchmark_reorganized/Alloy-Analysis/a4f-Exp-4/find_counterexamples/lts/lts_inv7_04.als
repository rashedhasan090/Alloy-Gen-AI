
/*
The LTS is reversible, i.e., from a reachable state it is always possible 
to return to an initial state.
*/
pred inv7 {
	all s1, s2:State, e:Event | s1->e->s2 in trans implies 
		(exists s3:State | s2->e->s3 in trans) and 
		(s2 in Init or (some s:Init | s->*s2))
}