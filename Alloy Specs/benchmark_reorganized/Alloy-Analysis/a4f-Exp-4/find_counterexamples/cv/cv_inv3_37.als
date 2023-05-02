
pred inv3_OK {
    all w1, w2 : Work, u : User | w1 != w2 and (w1 + w2) in u.profile and (w1.source != w2.source) implies no w1.ids & w2.ids 
}

The repaired inv3_OK predicate adds a "!=" (not equal) condition to the source comparison in the implication. This ensures that works added to a profile by different sources cannot have common identifiers.