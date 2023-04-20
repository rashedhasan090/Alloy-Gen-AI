The bug is in the inv4 predicate. The correct version of inv4 is:

/*
All states are reachable from an initial state.
*/
pred inv4 {
    let tr = {s1, s2: State, e: Event | s1->e->s2 in trans} |
    State in Init.^tr
}