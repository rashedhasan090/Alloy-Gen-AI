
/*
The LTS is deterministic, ie, each state has at most one transition for each event.
*/
pred inv3 {
	all s : State, e : Event | lone e.(s.trans) 
}