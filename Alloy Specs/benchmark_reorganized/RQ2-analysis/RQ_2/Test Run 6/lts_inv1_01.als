/*Fixed specification*/
/*
A labeled transition system (LTS) is comprised by States, a sub--set
of which are Initial, connected by transitions, here represented by
Events.
*/
sig State {
        trans : Event -> State
}
sig Init in State {}
sig Event {}
/*
The LTS does not contain deadlocks, ie, each state has at least a
transition.
*/
pred inv1 {
	all s: State | some s.trans
}
/*
There is a single initial state.
*/
pred inv2 {
	one s : Init | s = s
}
/*
The LTS is deterministic, ie, each state has at most a transition for each event.
*/
pred inv3 {
	all s: State, e: Event | lone e.s.trans
}
/*
All states are reachable from an initial state.
*/
pred inv4 {
	let tr = { s1, s2: State | some e: Event | s1->e->s2 in trans } |
	State in Init.^tr
}
/*
All the states have the same events available.
*/
pred inv5 {
	all s1, s2: State, e: Event | s1.trans.e = s2.trans.e
}
/*
Each event is available in at least a state.
*/
pred inv6 {
	all e: Event | some s: State | e in s.trans
}
/*
The LTS is reversible, ie, from a reachable state it is always possible
to return to an initial state.
*/
pred inv7 {
	let tr = { s1, s2: State | some e: Event | s1->e->s2 in trans } |
	all s: Init.^tr | some i: Init | i in s.^tr
}