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
        one i: Init | i in State --------correct
}
/*
The LTS is deterministic, ie, each state has at most a transition for each event.
*/
pred inv3 {
        all e: Event | lone s1, s2: State | s1.trans[e] = s2.trans[e] --------correct 
}
/*
All states are reachable from an initial state.
*/
pred inv4 {
        let tr = { s1, s2 : State, e : Event |
          s1 in Init and s1.trans[e] = s2 } |
        State = Init.^tr --------correct
}
/*
All the states have the same events available.
*/
pred inv5 {
        all e: Event |
        all s1, s2: State |
        s1.trans[e] != none and s2.trans[e] != none implies s1.trans[e] = s2.trans[e] --------correct
}
/*
Each event is available in at least a state.
*/
pred inv6 {
        all e: Event |
        some s1, s2: State |
        s1.trans[e] = s2 --------correct
}
/*
The LTS is reversible, ie, from a reachable state it is always possible 
to return to an initial state.
*/
pred inv7 {
        all s: State |
        some i: Init |
        some tr : s ->* i |
        tr = iden or some e: Event | tr = s.trans[e] -> tr & s.trans[e] ->* i --------correct
}

/*======== IFF PERFECT ORACLE ===============*/

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}
pred inv1_OK {
        all s: State | some s.trans --------correct
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}
pred inv2_OK {
        one i: Init | i in State --------correct
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}
pred inv3_OK {
        all e: Event | lone s1, s2: State | s1.trans[e] = s2.trans[e] --------correct
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
pred inv4_OK {
        let tr = { s1, s2 : State, e : Event |
          s1 in Init and s1.trans[e] = s2 } |
        State = Init.^tr --------correct
}

assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}
pred inv5_OK {
        all e: Event |
        all s1, s2: State |
        s1.trans[e] != none and s2.trans[e] != none implies s1.trans[e] = s2.trans[e] --------correct
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}
pred inv7_OK {
        all s: State |
        some i: Init |
        some tr : s ->* i |
        tr = iden or some e: Event | tr = s.trans[e] -> tr & s.trans[e] ->* i --------correct
}

run inv1_Repaired and inv2_Repaired and inv3_Repaired and inv4_Repaired and inv5_Repaired and inv7_Repaired for 3

check inv1_Repaired, inv2_Repaired, inv3_Repaired, inv4_Repaired, inv5_Repaired, inv7_Repaired for 6

pred repair_pred_1 { inv1[] iff inv1_OK[] }
run repair_pred_1
assert repair_assert_1 { inv1[] iff inv1_OK[] }
check repair_assert_1 for 1

```