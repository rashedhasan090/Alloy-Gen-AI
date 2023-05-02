The repaired code is as follows:

sig State {
    trans: Event -> State
}
sig Init in State {}
sig Event {}

pred inv1 {
    all s: State | some s.trans
}

pred inv2 {
    one s: Init
}

pred inv3 {
    all s: State, e: Event | lone e.(s.trans)
}

pred inv4 {
    let tr = {s1, s2: State | some e: Event | s1->e->s2 in trans} |
    State in Init.^tr
}

pred inv5 {
    all s, s': State, e: Event |
        (s->e->s').(trans) = (s'->e->s).(trans)
}

pred inv6 {
    all e: Event | some s1, s2: State | s1->e->s2 in trans
}

pred inv7 {
    let tr = {s1, s2: State | some e: Event | s1->e->s2 in trans} |
    all s: Init.^tr | some i: Init | i in s.^tr
}

check inv1
check inv2
check inv3
check inv4
check inv5
check inv6
check inv7