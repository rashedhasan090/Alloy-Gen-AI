There is a bug in the inv2 predicate. The correct version is provided below:

pred inv2 {
    all u:User, w:Work | w in u.profile implies (u in w.source or some i:Institution | i in i.source && i in w.source)
}