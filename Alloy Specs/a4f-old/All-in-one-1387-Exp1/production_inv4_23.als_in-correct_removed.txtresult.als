The bug is in the predicate inv4. The implication should be reversed. The fixed code is:

pred inv4 { // The parts required by a component cannot be assembled in a later position
    all c:Component, p:c.parts | p in Component implies c.cposition in p.cposition.*prev
}

pred inv4_OK {
    all c:Component | c.parts.cposition in c.cposition.*prev
}

assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}

check inv4_Repaired expect 0