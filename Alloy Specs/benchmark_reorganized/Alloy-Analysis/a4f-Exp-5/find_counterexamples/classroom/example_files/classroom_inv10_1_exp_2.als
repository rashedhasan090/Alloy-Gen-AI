pred inv10_OK {
  all c:Class, s:Student | some (c.Groups[s]) 
}
assert inv10_Repaired {
    inv10[] iff inv10_OK[]
}