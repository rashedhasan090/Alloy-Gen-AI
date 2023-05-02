The fixed version of the inv5 predicate is:

pred inv5 {
	all e:Event, s:State | some s1:State | s1->e->s in trans 
}