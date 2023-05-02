
pred inv2 {
	all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source)
	or some i:Institution | i in u.visible
}

Here the additional disjunction allows for works added by external institutions to be visible to the user, even if they are not part of the user's profile. The repaired code and additional repairs are:

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
	all u:User | u.visible in u.profile
} 
pred inv2 { // A user profile can only have works added by himself or some external institution
	all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source)
	or some i:Institution | i in u.visible
}
pred inv3 { // The works added to a profile by a given source cannot have common identifiers
	all w1, w2 : Work, u : User | w1 != w2 and (w1 + w2) in u.profile and (w1.source = w2.source) implies no w1.ids & w2.ids
}
/*======== IFF PERFECT ORACLE ===============*/
pred inv1_OK {
	all u:User | u.visible in u.profile
}
assert inv1_Repaired {
    inv1[] iff inv1_OK[]
}

pred inv2_OK {
	all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source)
	or some i:Institution | i in u.visible
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

---- PerfectOracleCommands
run inv1_Repaired for 3 but exactly 1 User, 3 Work, 2 Source, 2 Institution, 2 Id
run inv2_Repaired for 3 but exactly 1 User, 3 Work, 2 Source, 2 Institution, 2 Id
run inv3_Repaired for 3 but exactly 1 User, 3 Work, 2 Source, 2 Institution, 2 Id

---- Repair inv2
pred repair_inv2 {
    all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source or i in u.visible)
    or some i:Institution | i in u.visible
}
assert inv2_Repaired {
    inv2[] iff repair_inv2[]
}

check inv2_Repaired

---- Additional repairs
pred inv4 { // Source for a work and institution for a user cannot be the same
    all i: Institution, u: User, w: Work | w in u.profile and i in w.source implies not (i = u)
}
pred inv5 { // A work can only belong to one source
    all w: Work | lone s: Source | s in w.source
}
pred inv6 { // A profile cannot have duplicates
    all u: User | u.profile = u.profile
}
assert inv4_Repaired {
    inv4[] iff inv4_OK[]
}
assert inv5_Repaired {
    inv5[] iff inv5_OK[]
}
assert inv6_Repaired {
    inv6[] iff inv6_OK[]
}

---- Repair inv4
pred repair_inv4 {
    all i: Institution, u: User, w: Work | w in u.profile and i in w.source implies not (i = u)
}
assert inv4_Repaired {
    inv4[] iff repair_inv4[]
}

check inv4_Repaired

---- Repair inv5
pred repair_inv5 {
    all w: Work, s1: Source, s2: Source | w.source = s1 + s2 implies s1 = s2
}
assert inv5_Repaired {
    inv5[] iff repair_inv5[]
}

check inv5_Repaired

---- Repair inv6
pred repair_inv6 {
    all u: User | no w1, w2 : Work | w1 != w2 and (w1 + w2) in u.profile
}
assert inv6_Repaired {
    inv6[] iff repair_inv6[]
}

check inv6_Repaired