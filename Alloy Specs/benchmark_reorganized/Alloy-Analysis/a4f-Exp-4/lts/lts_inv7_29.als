
/*
The LTS is reversible, ie, for each reachable state s, there is a state s' such that
s can be reached from an initial state and S' can be reached from s.
*/
pred inv7_OK {
	let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
	all s : Init.^tr | some i : Init | i in s.^tr 
}