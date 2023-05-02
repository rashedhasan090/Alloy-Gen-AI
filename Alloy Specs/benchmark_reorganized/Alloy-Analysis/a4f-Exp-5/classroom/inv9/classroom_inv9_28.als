pred inv9_OK {
  all c:Class | lone p:Teacher | Teaches.p = c implies lone c.Groups 
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}