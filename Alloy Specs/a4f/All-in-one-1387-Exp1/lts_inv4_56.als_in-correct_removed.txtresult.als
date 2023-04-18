The bug is in the predicate inv4. The correct code for inv4 is:

pred inv4 {
    let tr = { s1, s2 : State, e : Event | s1->e->s2 in trans } |
    State in Init.^tr
}