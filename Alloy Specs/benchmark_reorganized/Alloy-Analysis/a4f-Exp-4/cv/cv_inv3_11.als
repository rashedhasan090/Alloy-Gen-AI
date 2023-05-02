
pred inv3 { // The works added to a profile by a given source cannot have common identifiers
  all u:User | lone w1, w2 : Work | w1 != w2 and (w1 + w2) in u.profile and (w1.source = w2.source) implies no w1.ids & w2.ids 
}

The "lone" keyword is used to ensure that there is at most one common identifier between any two works added to a profile by a given source.