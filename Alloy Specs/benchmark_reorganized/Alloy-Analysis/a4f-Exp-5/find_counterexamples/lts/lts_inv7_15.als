One possible fix for the bug in pred inv7 is to change the quantification from "all x : Event" to "all s : State". This way we check if it is possible to go from every reachable state back to an initial state for any event, rather than for every event.

Fixed code:

pred inv7_OK {
    let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
    all s : Init.^tr | some i : Init | i in s.^tr 
}

assert inv7_Repaired {
    inv7[] iff inv7_OK[]
}