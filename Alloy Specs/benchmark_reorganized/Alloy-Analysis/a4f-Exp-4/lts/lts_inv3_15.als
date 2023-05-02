
/*
The LTS is deterministic, ie, for each state and each event, there is at most a transition from that state for that event. 
*/
pred inv3 {
	all s : State, e : Event | lone e.(s.trans) 
}