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

// Fixed invariant 1: All works in the user's visible set must also be in their profile set
pred inv1 {
    all u: User | u.visible in u.profile
}

// Fixed invariant 2: A user's profile can only have works added by themselves or some external institution
pred inv2 {
    all u: User, w: Work |
        w in u.profile implies (u in w.source or some i: Institution | i in i.source)
}

// Fixed invariant 3: Works added to a user's profile by a given source cannot have common identifiers
pred inv3 {
    all u: User, w1, w2: Work |
        w1 != w2 and
        w1 in u.profile and w2 in u.profile and
        w1.source = w2.source implies no w1.ids & w2.ids
}

/*======== IFF PERFECT ORACLE ===============*/

pred inv1_OK {
    all u: User | u.visible in u.profile
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv2_OK {
    all u: User, w: Work |
        w in u.profile implies (u in w.source or some i: Institution | i in i.source)
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

pred inv3_OK {
    all u: User, w1, w2: Work |
        w1 != w2 and
        w1 in u.profile and w2 in u.profile and
        w1.source = w2.source implies no w1.ids & w2.ids
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

/*======== Verification ===============*/

check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0

/*======== Repair ===============*/

pred repair_pred_1 {
    inv1[] iff inv1_OK[]
}

run repair_pred_1

assert repair_assert_1 {
    inv1[] iff inv1_OK[]
}

check repair_assert_1