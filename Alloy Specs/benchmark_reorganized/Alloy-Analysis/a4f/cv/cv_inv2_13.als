
pred inv2 {
    all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source)
}

And the corresponding repaired invariant assertion is:

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}