There is a bug in inv2. The correct predicate is:

pred inv2 {
    all u : User | all w : u.profile | 
        ((User in w.source and w in u.visible) or (some i:Institution | i in w.source))
}