The bug was in the inv3 predicate. 

Incorrect Predicate:
pred inv3 {
 all s:State | s.trans.State in Event 
}

Corrected Predicate:
pred inv3 {
	all s : State, e : Event | lone e.(s.trans) 
}