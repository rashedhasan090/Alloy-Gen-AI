pred inv9_OK {
  all c:Class | lone c.Groups & Teacher
}
assert inv9_Repaired {
    inv9[] iff inv9_OK[]
}