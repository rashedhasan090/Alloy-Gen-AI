The bug in the specification is in the predicate inv7. The let binding for "tr" is commented out and thus the predicate is incomplete. 

The fixed code is as follows:

/*\n
A labeled transition system (LTS) is comprised by States, a sub-set\n
of which are Initial, connected by transitions, here represented by \n
Events.\n
*/\n
sig State {
        trans : Event -> State
}
sig Init in State {}
sig Event {}

/*\n
The LTS does not contain deadlocks, ie, each state has at least a \n
transition.\n
*/
pred inv1 {
    all s: State | some s.trans
}

/*\n
There is a single initial state.\n
*/
pred inv2 {
    one Init
}

/*\n
The LTS is deterministic, ie, each state has at most a transition for each event.\n
*/
pred inv3 {
    all s : State, e : Event | lone e.(s.trans)
}

/*\n
All states are reachable from an initial state.\n
*/
pred inv4 {
    let tr = { s1, s2 : State, e : Event | s1->e->s2 in trans } |
    State in Init.^tr
}

/*\n
All the states have the same events available.\n
*/
pred inv5 {
    all s1,s2 : State | s1.trans.Event = s2.trans.Event
}

/*\n
Each event is available in at least a state.\n
*/
pred inv6 {
    all e : Event | some s1,s2 : State | s1->e->s2 in trans
}

/*\n
The LTS is reversible, ie, from a reachable state it is always possible \n
to return to an initial state.\n
*/
pred inv7 {
    let tr = { s1, s2 : State, e : Event | s1->e->s2 in trans } |
    all s : Init.^tr | some i : Init | i in s.^tr 
}

/*======== IFF PERFECT ORACLE ===============*/
pred inv1_OK {
    all s: State | some s.trans
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

---------

pred inv2_OK {
    one Init
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

--------

pred inv3_OK {
    all s : State, e : Event | lone e.(s.trans)
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

--------

pred inv4_OK {
    let tr = { s1, s2 : State, e : Event | s1->e->s2 in trans } |
    State in Init.^tr
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

--------

pred inv5_OK {
    all s1,s2 : State | s1.trans.Event = s2.trans.Event
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

--------

pred inv7_OK {
    let tr = { s1, s2 : State, e : Event | s1->e->s2 in trans } |
    all s : Init.^tr | some i : Init | i in s.^tr 
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

--------

--- PerfectOracleCommands
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