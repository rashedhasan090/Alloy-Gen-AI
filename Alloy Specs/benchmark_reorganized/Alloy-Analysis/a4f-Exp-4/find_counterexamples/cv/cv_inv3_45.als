
pred inv3_OK {
    all w1, w2 : Work, u : User | w1 != w2 and (w1 + w2) in u.profile implies (no w1.ids & w2.ids) or (w1.source=w2.source and w1.ids=w2.ids)
}