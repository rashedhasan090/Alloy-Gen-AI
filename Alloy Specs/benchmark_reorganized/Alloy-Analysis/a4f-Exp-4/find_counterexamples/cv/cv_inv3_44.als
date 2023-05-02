There is a bug in inv3. The correct fixed code is:

pred inv3_OK { // The works added to a profile by a given source cannot have common identifiers
  all w1, w2:Work, u:User | ((w1 in u.profile and w2 in u.profile) and (w1 != w2) and (w1.source = w2.source)) implies no w1.ids & w2.ids 
}