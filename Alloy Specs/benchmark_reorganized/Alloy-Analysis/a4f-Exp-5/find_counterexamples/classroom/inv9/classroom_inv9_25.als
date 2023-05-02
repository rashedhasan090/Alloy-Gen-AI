pred inv9_OK {
  all c:Class,p:Person | lone c.Groups[p] & Teacher 
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}