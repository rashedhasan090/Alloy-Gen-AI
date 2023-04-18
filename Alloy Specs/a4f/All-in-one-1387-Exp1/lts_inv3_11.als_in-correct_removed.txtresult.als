The fixed code is:

/*
A labeled transition system (LTS) is comprised by States, a sub-set
of which are Initial, connected by transitions, here represented by 
Events.
*/

sig State {
        trans : Event -> State
}

sig Init in State {}
sig Event {}

/*
The LTS does not contain deadlocks, i.e., each state has at least a 
transition.
*/

pred inv1 {
    all s: State | some s.trans
}

/*
There is a single initial state.
*/

pred inv2 {
    one s: Init
}

/*
The LTS is deterministic, i.e., each state has at most a transition for each event.
*/

pred inv3 {
    all s: State, e: Event |
    (one t1: s.trans.e |
    all t2: s.trans.e | t1 = t2) -- each state has at most one transition for each event
}

/*
All states are reachable from an initial state.
*/

pred inv4 {
    Init in can_reach -- check if Init is reachable from itself
}

fact can_reach {
    init in Init
    all s: State | some e: Event |
    s -> e -> s'. s' in can_reach
}

/*
All the states have the same events available.
*/

pred inv5 {
    all s: State, s': State |
    s.trans.Event = s'.trans.Event
}

/*
Each event is available in at least one state.
*/

pred inv6 {
    all e: Event |
    some s: State | some s': State | s.trans.e = s'.trans.e
}

/*
The LTS is reversible, i.e., from a reachable state it is always possible 
to return to an initial state.
*/

pred inv7 {
    all s: State | some i: Init | s in can_reach_r(i) -- check if s is eventually in Init
}

fact can_reach_r(i: Init) {
    i in Init -- check if Init can reach itself
    all s: State | some e: Event | s.trans.e = i and
    (all s': State | s'.trans.e = s.trans.e implies
    (s in can_reach_r(i) iff s' in can_reach_r(i))) -- check for eventual reachability of s from Init
}

/*======== IFF PERFECT ORACLE ===============*/

pred inv1_OK {
    all s: State | some s.trans
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv2_OK {
    one s: Init
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

pred inv3_OK {
    all s: State, e: Event |
    (one t1: s.trans.e |
    all t2: s.trans.e | t1 = t2)
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

pred inv4_OK {
    Init in can_reach
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

pred inv5_OK {
    all s: State, s': State |
    s.trans.Event = s'.trans.Event
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

pred inv7_OK {
    all s: State | some i: Init | s in can_reach_r(i)
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

--- PerfectOracleCommands

check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv7_Repaired expect 0

pred repair_pred_1{inv3[] iff inv3_OK[] }

run repair_pred_1

assert repair_assert_1{inv3[] iff inv3_OK[] }

check repair_assert_1