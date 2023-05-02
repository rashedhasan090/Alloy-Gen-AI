
The fixed code for inv2 is as follows:

pred inv2_OK {
    all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source and i != u) 
}