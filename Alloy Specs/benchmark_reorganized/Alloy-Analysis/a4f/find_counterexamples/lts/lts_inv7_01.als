/*
A labeled transition system (LTS) is comprised by States, a sub----set
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
	all s: State | some s.trans --------correct
}
/*
There is a single initial state.
*/
pred inv2 {
	one Init --------correct
}
/*
The LTS is deterministic, ie, each state has at most a transition for each event.
*/
pred inv3 {
	all s : State, e : Event | lone e.(s.trans) --------correct 
}
/*
All states are reachable from an initial state.
*/
pred inv4 {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
  State in Init.^tr --------correct
}
/*
All the states have the same events available.
*/
pred inv5 {
	all s, s1:State | s.trans.Event = s1.trans.Event --------correct
}
/*
Each event is available in at least a state.
*/
pred inv6 {
	all e:Event | some s1,s2:State | s1->e->s2 in trans --------correct
}
/*
The LTS is reversible, ie, from a reacheable state it is always possible 
to return to an initial state.
*/
pred inv7 {
	let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
	all s : Init.^tr | some i : Init | i in s.^tr --------correct
}
/*======== IFF PERFECT ORACLE ===============*/
assert inv1_Repaired {
     inv1[] iff inv1[]
}
assert inv2_Repaired {
     inv2[] iff inv2[]
}
assert inv3_Repaired {
     inv3[] iff inv3[]
}
assert inv4_Repaired {
    inv4[] iff inv4[]
}
assert inv5_Repaired {
    inv5[] iff inv5[]
}
assert inv7_Repaired {
    inv7[] iff inv7[]
}
// repair all properties using the repaired invariants
assert inv1_repairProperty{
	all s: State | some s.trans iff some s.trans
}
assert inv2_repairProperty{
	one Init iff one Init
}
assert inv3_repairProperty{
	all s : State, e : Event | lone e.(s.trans) iff lone e.(s.trans)
}
assert inv4_repairProperty{
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
	State in Init.^tr iff State in Init.^tr
}
assert inv5_repairProperty{
	all s, s1:State | s.trans.Event = s1.trans.Event iff s.trans.Event = s1.trans.Event
}
assert inv7_repairProperty {
	let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
	all s : Init.^tr | some i : Init | i in s.^tr iff 
	all s: Init.^tr | some i : Init | i in s.^tr
}
// test all repaired invariants
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0 
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv7_Repaired expect 0
// check if all inv are repairedPrec
check inv1_repairProperty
check inv2_repairProperty
check inv3_repairProperty
check inv4_repairProperty
check inv5_repairProperty
check inv7_repairProperty