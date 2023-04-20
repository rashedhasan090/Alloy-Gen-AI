There is a bug in pred inv7. The let clause should be commented out instead of the entire predicate.

Fixed code:

pred inv7 {
    -- let tr = { s1, s2 : State | some e : Event | s1->e->s2 in trans } |
    all s : Init.^trans | some i : Init | i in s.^trans
}