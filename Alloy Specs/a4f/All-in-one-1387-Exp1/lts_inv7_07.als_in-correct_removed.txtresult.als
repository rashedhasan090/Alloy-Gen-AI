There is a commented out section in the inv7 predicate. The bug is that it should not be commented out.

Fixed code:

/* Labeled transition system (LTS) with states, events, and transitions. */
sig State {
    trans : Event -> State
}

/* Initial states */
sig Init in State {}

/* Events */
sig Event {}

/* Invariant: each state has at least one transition. */
pred inv1 {
    all s: State | some s.trans
}

/* Invariant: there is a single initial state. */
pred inv2 {
    one Init
}

/* Invariant: the LTS is deterministic. */
pred inv3 {
    all s : State, e : Event | lone e.(s.trans)
}

/* Invariant: all states are reachable from an initial state. */
pred inv4 {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
    State in Init.^tr
}

/* Invariant: all the states have the same events available. */
pred inv5 {
    all s:State, s1:State | s.trans.State = s1.trans.State
}

/* Invariant: each event is available in at least one state. */
pred inv6 {
    all e:Event | some s1,s2:State | s1->e->s2 in trans
}

/* Invariant: the LTS is reversible. */
pred inv7 {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
    all s : Init.^tr | some i : Init | i in s.^tr
}

/* Invariant repair predicates */
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
    all s : State, e : Event | lone e.(s.trans)
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

pred inv4_OK {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
    State in Init.^tr
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

pred inv5_OK {
    all s:State, s1:State | s.trans.State = s1.trans.State
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}

pred inv7_OK {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
    all s : Init.^tr | some i : Init | i in s.^tr
}
assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}

/* Check repaired invariants */
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv7_Repaired expect 0

/* Repair predicate and assert */
pred repair_pred_1 {
    inv7[] iff inv7_OK[]
}
run repair_pred_1
assert repair_assert_1 {
    inv7[] iff inv7_OK[]
}
check repair_assert_1