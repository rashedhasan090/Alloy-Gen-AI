pred inv9_OK {
  all c:Class,t:Teacher | lone c.Groups.[t] 
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}