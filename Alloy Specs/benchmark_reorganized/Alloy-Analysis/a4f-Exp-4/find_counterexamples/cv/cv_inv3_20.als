
pred inv3_OK {
    all w1: Work, w2: Work, u: User | (w1 != w2) and (w1 in u.profile) and (w2 in u.profile) 
        and (w1.source = w2.source) implies no id: Id | id in w1.ids and id in w2.ids
}

The condition for identifying conflicts between works is that they have at least one common id.