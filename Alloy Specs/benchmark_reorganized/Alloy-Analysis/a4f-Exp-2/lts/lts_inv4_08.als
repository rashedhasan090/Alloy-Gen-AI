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
    one Init 
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
    all s: State | some i: Init | i in s.*
}

/*
All the states have the same events available.
*/
pred inv5 {
    all s, s': State | s.trans.Event = s'.trans.Event
}

/*
Each event is available in at least a state.
*/
pred inv6 {
    all e: Event | some s: State | e in s.trans.Event
}

/*
The LTS is reversible, ie, from a reachable state it is always possible 
to return to an initial state.
*/
pred inv7 {
    let tr = {s1, s2: State | some e: Event | s1->e->s2 in trans} |
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
    one Init 
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
    all s: State | some i: Init | i in s.*
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

pred inv5_OK {
    all s, s': State | s.trans.Event = s'.trans.Event
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

pred inv7_OK {
    let tr = {s1, s2: State | some e: Event | s1->e->s2 in trans} |
    all s: Init.^tr | some i: Init | i in s.^tr
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

/*===============================
          TEST CASES
================================*/

// Test case to check inv1 and inv1_OK
run {
    assert inv1
    assert inv1_OK
    not (inv1 and not inv1_OK)
}

// Test case to check inv2 and inv2_OK
run {
    assert inv2
    assert inv2_OK
    not (inv2 and not inv2_OK)
}

// Test case to check inv3 and inv3_OK
run {
    assert inv3
    assert inv3_OK
    not (inv3 and not inv3_OK)
}

// Test case to check inv4 and inv4_OK
run {
    assert inv4
    assert inv4_OK
    not (inv4 and not inv4_OK)
}

// Test case to check inv5 and inv5_OK
run {
    assert inv5
    assert inv5_OK
    not (inv5 and not inv5_OK)
}

// Test case to check inv7 and inv7_OK
run {
    assert inv7
    assert inv7_OK
    not (inv7 and not inv7_OK)
}