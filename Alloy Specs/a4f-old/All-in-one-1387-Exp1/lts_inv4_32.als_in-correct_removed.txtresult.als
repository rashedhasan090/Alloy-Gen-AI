The bug in the above specification is in the predicate "inv4". The correct implementation of the predicate is as follows:

/* All states are reachable from an initial state. */
pred inv4 {
    let tr = { s1, s2 : State, e : Event | s1->e->s2 } |
    State in Init.^tr
}

The only change here is in the let expression of the predicate, changing "some e : Event" to "s1->e->s2". This ensures that only those transitions are considered in the let expression which are valid transitions between two states connected by an event.