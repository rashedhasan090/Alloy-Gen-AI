/* The bug in inv4 is fixed by adding a quantifier over all states
   rather than events, and removing the unnecessary some operator. */
pred inv4_OK {
    all s: State | some Init.(s.*trans)
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}