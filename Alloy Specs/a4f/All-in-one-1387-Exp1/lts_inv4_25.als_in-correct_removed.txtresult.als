The bug in the specification is in the predicate inv4. The correct inv4 predicate should be:

/* All states are reachable from an initial state. */
pred inv4 {
    let tr = { s1, s2 : State, e : Event | s1->e->s2 in trans } |
    State in Init.^tr
}

The corrected version includes the event e in the relation tr.