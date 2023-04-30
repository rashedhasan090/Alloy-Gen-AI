The bug was in inv2. The original predicate did not allow a work to be added to a user's profile by an external institution if it was not added by the user himself. The repaired version allows a work to be added by an external institution as long as it is not already in the user's profile. The fixed code is as follows:

pred inv2_OK {
    all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | (i in w.source and w not in i.visible))
}

assert inv2_Repaired {
    inv2[] iff inv2_OK[]
}