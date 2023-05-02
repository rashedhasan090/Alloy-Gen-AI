
Here is the fixed code for the inv2 predicate:

pred inv2 {
    all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in w.source) 
}