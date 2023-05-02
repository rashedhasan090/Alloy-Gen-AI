
pred inv3_OK { // The works added to a profile by a given source cannot have common identifiers
    all w1, w2:Work, u:User | (w1 in u.profile and w2 in u.profile and w1 != w2) implies (w1.ids & w2.ids = none) and (w1.source != w2.source)
}

// The repaired invariant using the Perfect Oracle is:
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
} 

// The repaired predicate and assertion hold:
pred repair_pred_1 {
    inv3[] iff inv3_OK[]
}
run repair_pred_1
assert repair_assert_1 {
    inv3[] iff inv3_OK[]
}
check repair_assert_1