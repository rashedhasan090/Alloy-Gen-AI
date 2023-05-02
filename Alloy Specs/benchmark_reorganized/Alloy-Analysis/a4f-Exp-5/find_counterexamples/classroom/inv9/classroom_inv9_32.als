pred inv9_OK {
  all c:Class,t:Teacher | lone (t->c) & Teacher 
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}