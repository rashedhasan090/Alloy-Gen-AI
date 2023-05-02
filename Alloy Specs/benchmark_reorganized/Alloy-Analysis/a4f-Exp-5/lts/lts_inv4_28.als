/* Fixed code below */
pred inv4_OK {
	let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
	all s : (State--Init) | s in tr.(Init)
}