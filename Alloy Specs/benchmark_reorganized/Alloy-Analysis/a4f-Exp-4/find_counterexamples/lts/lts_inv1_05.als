
pred inv1 {
	all s1, s2:State, e:Event | s1->e->s2 in trans implies s1!=s2 
}

This adds a quantifier for the event e, which was missing in the original version.