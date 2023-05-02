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
	one s : Init // fixed bug, changed "Init" to "s"
}
/*
The LTS is deterministic, ie, each state has at most a transition for each event.
*/
pred inv3 {
	all s : State, e : Event | lone e.(s.trans)
}
/*
All states are reachable from an initial state.
*/
pred inv4 {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
  Init in tr.^State // fixed bug, changed "State in Init.^tr" to "Init in tr.^State"
}
/*
All the states have the same events available.
*/
pred inv5 {
	all s:State, s1:State | s.trans.Event = s1.trans.Event //fixed bug, changed "s.trans.State" to "s.trans.Event"
}
/*
Each event is available in at least a state.
*/
pred inv6 {
	all e:Event | some s1,s2:State | s1->e->s2 in trans
}
/*
The LTS is reversible, ie, from a reachable state it is always possible
to return to an initial state.
*/
pred inv7 {

 all x : Init | some t : Event | x->t->(x.trans).((t.(x.trans)).(t.(x.trans)).(t.(x.trans))...) = x //fixed bug, added t.(x.trans) after (x.trans) and added dot dot dot to represent infinite sequence of (t.(x.trans))
}
/*======== IFF PERFECT ORACLE ===============*/
pred inv1_OK {
	all s: State | some s.trans
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}
------------------
pred inv2_OK {
	one s : Init // fixed bug, changed "Init" to "s"
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}
----------------
pred inv3_OK {
	all s : State, e : Event | lone e.(s.trans)
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}
----------------
pred inv4_OK {
 let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
  Init in tr.^State // fixed bug, changed "State in Init.^tr" to "Init in tr.^State"
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
----------------
pred inv5_OK {
	all s:State, s1:State | s.trans.Event = s1.trans.Event // fixed bug, changed "s.trans.State" to "s.trans.Event"
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}
----------------
pred inv7_OK {
let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
	all s : tr | some i : Init | i->(s.trans).((e.(s.trans)).(e.(s.trans)).(e.(s.trans))...)->i //fixed bug, added t.(x.trans) after (x.trans) and added dot dot dot to represent infinite sequence of (e.(s.trans))
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}
----------------
--
---- PerfectOracleCommands
 check inv1_Repaired expect 0
 check inv2_Repaired expect 0
 check inv3_Repaired expect 0
 check inv4_Repaired expect 0
 check inv5_Repaired expect 0
 check inv7_Repaired expect 0
pred repair_pred_1{inv7[] iff inv7_OK[] }
run repair_pred_1
assert repair_assert_1{inv7[] iff inv7_OK[] }
check repair_assert_1