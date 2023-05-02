// BUG FIXED: Added a User check inside the quantification to ensure that the works are only considered if they belong to a user
pred inv1 { 
  all u:User, w : Work | w in u.visible implies (w in u.profile)
}

// Remaining invariants unchanged
pred inv2 { 
  all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source) 
}

pred inv3 { 
  all w1, w2 : Work, u : User | w1 != w2 and (w1 + w2) in u.profile and (w1.source = w2.source) implies no w1.ids & w2.ids 
}

// Assertions unchanged
pred inv1_OK {
    all u:User | u.visible in u.profile 
}

assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv2_OK {
    all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source) 
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

pred inv3_OK {
    all w1, w2 : Work, u : User | w1 != w2 and (w1 + w2) in u.profile and (w1.source = w2.source) implies no w1.ids & w2.ids 
}

assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}

// Commands unchanged
check inv1_Repaired expect 0
check inv2_Repaired expect 0
check inv3_Repaired expect 0 

run repair_pred_1

assert repair_assert_1{inv1[] iff inv1_OK[] }

check repair_assert_1