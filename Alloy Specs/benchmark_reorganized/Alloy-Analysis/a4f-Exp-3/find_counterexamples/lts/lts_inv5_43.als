/* Fixed Alloy specification: */

/*
A labeled transition system (LTS) is comprised by States, a sub--set
of which are Initial, connected by transitions, here represented by 
Events.
*/
sig State {
    trans: Event -> State
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
    one s: Init | s in State
}

/*
The LTS is deterministic, ie, each state has at most a transition for each event.
*/
pred inv3 {
    all s: State, e: Event | lone e.(s.trans)
}

/*
All states are reachable from an initial state.
*/
pred inv4 {
    let tr = {s1, s2: State | some e: Event | s1 -> e -> s2 in trans} |
    State in Init.^tr
}

/*
All the states have the same events available.
*/
pred inv5 {
    all x, y: State | x.trans.event = y.trans.event
}

/*
Each event is available in at least a state.
*/
pred inv6 {
    all e: Event | some s: State | e in s.trans.event
}

/*
The LTS is reversible, ie, from a reachable state it is always possible 
to return to an initial state.
*/
pred inv7 {
    let tr = {s1, s2: State | some e: Event | s1 -> e -> s2 in trans} |
    all s: Init.^tr | some i: Init | i in s.^tr
}

/*======== IFF PERFECT ORACLE ===============*/

pred inv1_OK {
    all s: State | some s.trans
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv2_OK {
    one s: Init | s in State
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

pred inv3_OK {
    all s: State, e: Event | lone e.(s.trans)
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

pred inv4_OK {
    let tr = {s1, s2: State | some e: Event | s1 -> e -> s2 in trans} |
    State in Init.^tr
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

pred inv5_OK {
    all x, y: State | x.trans.event = y.trans.event
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

pred inv7_OK {
    let tr = {s1, s2: State | some e: Event | s1 -> e -> s2 in trans} |
    all s: Init.^tr | some i: Init | i in s.^tr
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

/*
Check that all repaired invariants hold.
*/
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv7_Repaired expect 0

/*
Attempt to repair invariant inv5 by changing the definition.
*/
pred repair_inv5 {
    all x: State, e: Event | some y: State | x.trans[e] = y
}
run repair_inv5
/*
Check that the attempted repair does not hold.
*/
assert repair_inv5_fails {
    not (inv5[] iff repair_inv5[])
}
check repair_inv5_fails