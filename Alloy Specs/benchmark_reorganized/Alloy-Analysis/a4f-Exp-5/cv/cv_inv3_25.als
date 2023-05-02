abstract sig Source {}
sig User extends Source {
    profile : set Work,
    visible : set Work
}
sig Institution extends Source {}
sig Id {}
sig Work {
    ids : some Id,
    source : one Source
}

pred inv1 { 
    all u:User | u.visible in u.profile 
}

pred inv2 { 
    all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source) 
}

pred inv3 { 
    all w1, w2:Work, u:User | (w1 in u.profile and w2 in u.profile and w1 != w2) implies no (w1.ids & w2.ids) 
}

pred inv3_OK {
    all w1, w2 : Work, u : User | w1 != w2 and (w1 + w2) in u.profile and (w1.source = w2.source) implies no w1.ids & w2.ids 
}

pred repair_pred_1{inv3[] iff inv3_OK[] }
run repair_pred_1

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

assert repair_assert_1{inv3[] iff inv3_OK[] }

check inv1_Repaired
check inv2_Repaired
check repair_assert_1