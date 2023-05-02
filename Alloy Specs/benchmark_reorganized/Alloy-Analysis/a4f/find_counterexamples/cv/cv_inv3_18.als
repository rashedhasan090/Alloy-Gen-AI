
pred inv3 {
    all w1, w2:Work, u:User | (w1.source = w2.source and w1.ids = w2.ids and w1 != w2) implies no ((w1 + w2) in u.profile)
}

And the repaired version of inv3 (inv3_OK) is:

pred inv3_OK {
    all w1, w2:Work, u:User | (w1.source = w2.source and w1.ids = w2.ids and w1 != w2) implies no w1.ids & w2.ids
}