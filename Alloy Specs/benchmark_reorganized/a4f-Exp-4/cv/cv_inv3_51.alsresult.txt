There is a bug in the inv3 predicate. The fixed code is provided below:

pred inv3_OK { // The works added to a profile by a given source cannot have common identifiers
  all u:User , s:Source| lone (u.profile & s.source.ids) 
}