abstract sig Source {}
sig User extends Source {
    profile: set Work,
    visible: set Work
}
sig Institution extends Source {}
sig Id {}
sig Work {
    ids: some Id,
    source: one Source
}

pred inv1 {
    all u: User | u.visible in u.profile
}

pred inv2 {
    all u: User, w: Work | w in u.profile implies (u in w.source or w.source in Institution)
}

pred inv3 {
    all disj w1, w2: Work, u: User | (w1 + w2) in u.profile and w1.source = w2.source implies no w1.ids & w2.ids
}

pred repair_pred_1 {
    inv2[] iff all u: User, w: Work | w in u.profile implies (u in w.source or w.source in Institution)
}

run repair_pred_1

assert repaired_inv2 {
    inv2[] iff all u: User, w: Work | w in u.profile implies (u in w.source or w.source in Institution)
}

check repaired_inv2

assert inv1_hold {
    inv1[]
}

assert inv2_hold {
    inv2[]
}

assert inv3_hold {
    inv3[]
}

check inv1_hold expect 0
check inv2_hold expect 0
check inv3_hold expect 0