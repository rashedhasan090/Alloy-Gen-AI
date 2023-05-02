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
    all s: State | some s.trans
}
/*
There is a single initial state.
*/
pred inv2 {
    one s: State | s in Init
}
/*
The LTS is deterministic, ie, each state has at most a transition for each event.
*/
pred inv3 {
    all e: Event, s: State | lone s'.s.trans[e] = s'
}
/*
All states are reachable from an initial state.
*/
pred inv4 {
    all s: State | some (s in Init) or (s in (State ---- Init) and some e: Event | s.e->s'.s in Init)
}
/*
All the states have the same events available.
*/
pred inv5 {
    all s1, s2: State, e: Event | (e in s1.trans) <=> (e in s2.trans)
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
    all s, s': State | some (s in Init.^~s') or ((s'.s).Init)
}

/*======== IFF PERFECT ORACLE ===============*/

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

/*
Repairing inv1 by using corrected code from inv1_OK.
*/
pred repair_pred_1{
    inv1[] iff inv1_OK[]
}
run repair_pred_1
assert repair_assert_1{
    inv1[] iff inv1_OK[]
}

check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0 
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv7_Repaired expect 0
check repair_assert_1