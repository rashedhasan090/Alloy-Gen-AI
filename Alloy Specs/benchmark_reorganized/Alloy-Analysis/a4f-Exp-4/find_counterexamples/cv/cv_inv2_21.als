There is a bug in the specification of inv2. Specifically, the current formulation of inv2 does not allow a user to add a work to their profile that belongs to any Institution. This is because the condition "i in w.source" is only satisfied when the source of a work is an Institution, but not when it is a User. To fix this, we need to change the condition to "i = w.source or i in w.source.User". The corrected code is as follows:

pred inv2_OK {
	all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i = w.source or i in w.source.User) 
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}

check inv2_Repaired expect 0