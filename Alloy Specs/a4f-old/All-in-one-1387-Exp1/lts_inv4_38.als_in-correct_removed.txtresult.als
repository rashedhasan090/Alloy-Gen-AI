The bug is in the predicate inv4. The correct version is:

pred inv4 {
    let tr = { s1, s2 : State, e : Event | s1->e->s2 in trans } |
        State in Init.^tr
}

The fixed version includes the event in the let binding and adds commas to separate multiple generator expressions.