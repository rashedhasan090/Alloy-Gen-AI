
pred inv3_OK {
    all w1, w2 : Work, u : User | w1 != w2 and (w1 + w2) in u.profile and (w1.source = w2.source) implies no w1.ids & w2.ids
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

check inv3_Repaired expect 0