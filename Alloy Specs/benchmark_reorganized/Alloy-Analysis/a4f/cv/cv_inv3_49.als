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
// Specify the following invariants!
// You can check their correctness with the different commands and
// specifying a given invariant you can assume the others to be true.
pred inv1 { // The works publicly visible in a curriculum must be part of its profile
	all u:User | u.visible in u.profile ----correct
}
pred inv2 { // A user profile can only have works added by himself or some external institution
 all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source) ----correct
}
pred inv3 { // The works added to a profile by a given source cannot have common identifiers
	all w1, w2:Work, u:User | ((w1 in u.profile and w2 in u.profile) and (w1.source = w2.source) and (w1 != w2)) implies (w1.ids != w2.ids) ----fixed
}
/*======== IFF PERFECT ORACLE ===============*/
pred inv1_OK {
	all u:User | u.visible in u.profile ----correct
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}
------------------
pred inv2_OK {
		all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source) ----correct
}
assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}
----------------
pred inv3_OK {
	all w1, w2:Work, u:User | ((w1 in u.profile and w2 in u.profile) and (w1.source = w2.source) and (w1 != w2)) implies (w1.ids != w2.ids) ----fixed
}
assert inv3_Repaired {
    inv3[] iff inv3_OK[]
}
---- PerfectOracleCommands
 check inv1_Repaired expect 0
 check inv2_Repaired expect 0
 check inv3_Repaired expect 0 
pred repair_pred_1{inv3[] iff inv3_OK[] }
run repair_pred_1
assert repair_assert_1{inv3[] iff inv3_OK[] }
check repair_assert_1