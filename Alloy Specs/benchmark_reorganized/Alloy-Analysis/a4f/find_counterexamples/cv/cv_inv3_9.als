
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
    all u: User, w: Work | w in u.profile implies (u in w.source or some i: Institution | i in w.source)
}

pred inv3 {
    all w: Work, w1: Work | w != w1 and w.source = w1.source and w in w1.User.profile implies w.ids != w1.ids
}

pred inv1_OK {
    all u: User | u.visible in u.profile
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv2_OK {
    all u: User, w: Work | w in u.profile implies (u in w.source or some i: Institution | i in w.source)
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

pred inv3_OK {
    all w: Work, w1: Work | w != w1 and w.source = w1.source and w in w1.User.profile implies w.ids != w1.ids
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0

pred repair_pred_1 {
    inv3[] iff inv3_OK[]
}

run repair_pred_1

assert repair_assert_1 {
    inv3[] iff inv3_OK[]
}

check repair_assert_1