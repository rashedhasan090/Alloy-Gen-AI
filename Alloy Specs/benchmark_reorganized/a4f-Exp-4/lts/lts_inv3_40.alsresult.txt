The bug was in the inv3 predicate, where it was using the dot notation to access the 'trans' relation, but it should have used the arrow notation instead. The fixed inv3 predicate is:

pred inv3_OK {
	all s : State, e : Event | lone e->(s.trans) 
}