// Bug fixed
pred inv1 {
	no s : State | no e : Event | s.trans[e] = s
} 

sig State {
    trans : Event -> State
}
sig Init in State {}
sig Event {}

pred inv2 {
    one Init
}

pred inv3 {
    all s: State, e: Event | lone e.(s.trans)
}

pred inv4 {
    let tr = {s1, s2: State | some e: Event | s1->e->s2 in trans} |
    State in Init.^tr
}

pred inv5 {
    all s: State, s1: State | s.trans.Event = s1.trans.Event
}

pred inv6 {
    all e: Event | some s1, s2: State | s1->e->s2 in trans
}

pred inv7 {
    let tr = {s1, s2: State | some e: Event | s1->e->s2 in trans} |
    all s: Init.^tr | some i: Init | i in s.^tr
}

pred inv1_OK {
    all s: State | some s.trans
}

pred repair_pred_1{
    inv1[] iff inv1_OK[]
}

assert inv1_Repaired {
    repair_pred_1
}

assert inv2_Repaired {
    inv2
}

assert inv3_Repaired {
    inv3
}

assert inv4_Repaired {
    inv4
}

assert inv5_Repaired {
    inv5
}

assert inv7_Repaired {
    inv7
}

check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0
check inv4_Repaired expect 0
check inv5_Repaired expect 0
check inv7_Repaired expect 0

assert repair_assert_1 {
    inv1[] iff inv1_OK[]
}

check repair_assert_1 expect 0