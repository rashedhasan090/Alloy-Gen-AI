The bug in the specification is in inv7. The commented out code should be replaced with the correct code:

pred inv7 {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 } |
    all s : Init | some i : Init | i in s.^tr --fixed
}

The fixed code considers all reachable states from initial states and checks if there is at least one initial state that can be reached from each reachable state.